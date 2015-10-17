package com.lj.tps.service

import com.lj.csp.data.Member
import com.lj.rmp.enumcustom.FileExts
import com.lj.rmp.enumcustom.ReCode
import com.lj.rmp.enumcustom.ResourceType
import com.lj.rmp.utils.I18nError
import com.lj.tps.data.TpsResourceFileInfo
import org.apache.commons.fileupload.servlet.ServletFileUpload
import org.springframework.web.multipart.MultipartHttpServletRequest
import org.springframework.web.multipart.commons.CommonsMultipartFile

class TpsResourceFileService {
    def webUtilForRmpService;
    def uploadFileService;
    def springSecurityService;

    def grailsApplication;
    def g = new org.codehaus.groovy.grails.plugins.web.taglib.ApplicationTagLib();

    def uploadFile() {
        //最大文件大小
        long maxSize = 100 * 1024 * 1024;
        String maxSizeStr=grailsApplication.config.grails.resouce.maxsize;
        if(maxSizeStr){
            try {
                maxSize=Long.parseLong(maxSizeStr);
            }catch (Exception ex){
                //ex.printStackTrace();
            }
        }

        def request = webUtilForRmpService.getRequest();
        //def params = request.getParameterMap();
        String dirNameParam = request.getParameter("dir");
        if (!ServletFileUpload.isMultipartContent(request)) {
            log.warn("Not multipart");
            return [recode: ReCode.SUBMIT_FORMAT_ERROR];
        }
        MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
        Map items = multiRequest.getMultiFileMap();
        Iterator itr = items.keySet().iterator();
        def recodes = [];
        while (itr.hasNext()) {
            List fileItems = items.get(itr.next());
            int itemCount = fileItems.size();
            for (int i = 0; i < itemCount; i++) {
                CommonsMultipartFile item = (CommonsMultipartFile) fileItems.get(i);
                // 判断是否上传文件
                if (item != null && !item.isEmpty()) {
                    String fileName = item.getOriginalFilename();
                    long fileSize = item.getSize();
                    //检查文件大小
                    if (fileSize > maxSize) {
                        log.info("上传文件大小超过限制。");
                        recodes.add([fileName: fileName, recode: ReCode.FILE_IS_TOO_BIG]);
                        continue;
                    }
                    String dirName = null;
                    if (dirNameParam == null) {
                        dirName = getDirName(fileName);
                    } else{
                        //检查扩展名
                        String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
                        if(!Arrays.<String>asList(FileExts.extMap.get(dirNameParam).split(",")).contains(fileExt)){
                            log.info("上传文件扩展名是不允许的扩展名。");
                            recodes.add([fileName: fileName, recode: ReCode.FILE_EXT_NOT_ALLOW]);
                            continue;
                        }
                        dirName=dirNameParam;
                    }

                    if (dirName == null) {
                        log.info("上传文件扩展名是不允许的扩展名。");
                        recodes.add([fileName: fileName, recode: ReCode.FILE_EXT_NOT_ALLOW]);
                        continue;
                    }
                    String fileFullName = uploadFileService.upload(item.getInputStream(), fileName, dirName);
                    if (fileFullName == null) {
                        log.info("上传文件失败。");
                        recodes.add([fileName: fileName, recode: ReCode.UPLOAD_FILE_FAILED]);
                        continue;
                    }
                    //写入数据到数据库
                    fileSize=uploadFileService.getFileSize(fileFullName);
                    //int size = fileSize;
                    int type = getFileType(dirName);
                    TpsResourceFileInfo resourceFileInfo = new TpsResourceFileInfo();
                    resourceFileInfo.size = fileSize;
                    resourceFileInfo.dirName = dirName;
                    resourceFileInfo.fileName = fileName;
                    resourceFileInfo.fileFullName = fileFullName;
                    resourceFileInfo.type = type;
                    resourceFileInfo.member=springSecurityService.currentUser;
                    if (!resourceFileInfo.save(flush: true)) {
                        recodes.add([fileName: fileName, recode: ReCode.SAVE_FAILED, errors: I18nError.getMessage(g, resourceFileInfo.errors.allErrors)]);
                        continue;
                    }
                    recodes.add([fileName: fileName, recode: ReCode.OK, fileFullName: fileFullName]);
                }
            }
        }
        return [recode: ReCode.OK, recodes: recodes];
    }

    private int getFileType(String dirName) {
        if (dirName == "image") {
            return ResourceType.IMAGE.code;
        } else if (dirName == "flash") {
            return ResourceType.FLASH.code;
        } else if (dirName == "media") {
            return ResourceType.MEDIA.code;
        } else {
            return ResourceType.FILE.code;
        }
    }

    private String getDirName(String fileName) {
        String dirName = null;
        String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
        Set<String> keys = FileExts.extMap.keySet();
        Iterator itr = keys.iterator();
        while (itr.hasNext()) {
            String key = itr.next();
            String exts = FileExts.extMap.get(key);
            if (Arrays.<String> asList(exts.split(",")).contains(fileExt)) {
                dirName = key;
                break;
            }
        }
        return dirName;
    }

    /***************
     * 文件查找
     *
     * params是传入的参数
     * 参数格式为：
     * id ID，非必须
     * offset,非必须
     * max,非必须
     *
     * 返回值
     * [recode: ReCode.OK,imageList:imageList,totalCount:totalCount];查询成功
     * **********************/
    //def search(def params) {
    def search(def params) {
        def request = webUtilForRmpService.getRequest();
        //def params = request.getParameterMap();
        log.info("params->"+params.id);
        //def session = webUtilForRmpService.getSession();
        //SimpleDateFormat sdfDate=new SimpleDateFormat("yyyy-MM-dd");
        //SimpleDateFormat sdfTime=new SimpleDateFormat("HH:mm:ss");
        //获取参数
        long id = com.lj.rmp.utils.Number.toLong(params.id);//图片信息ID
        int type = com.lj.rmp.utils.Number.toInteger(params.type);//图片所在的类别ID

//        //检查店铺可用性
//        def reInfo = shopService.getShopEnabled();
//        if (reInfo.recode != ReCode.OK) {
//            return reInfo;
//        }
        def resourceFileInfoList =null;
        def totalCount =0;
        Member member=springSecurityService.currentUser;
        if(member){
            if (!params.max) {
                params.max = 10
            }
            if (!params.offset) {
                params.offset = 0;
            }
            //查询图片
            def condition = {
                if (id) {
                    eq("id", id);
                }
                if (type) {
                    eq("type", type);
                }
                eq("member.id",member.id);
            }
            resourceFileInfoList = TpsResourceFileInfo.createCriteria().list(params, condition);
            totalCount = TpsResourceFileInfo.createCriteria().count(condition);
        }
        return [recode: ReCode.OK, resourceFileInfoList: resourceFileInfoList, totalCount: totalCount];
    }

    /***************
     * 文件删除
     *
     * params是传入的参数
     * 参数格式为：
     * ids ID数组，必须
     *
     * 返回值
     * [recode: ReCode.NO_RESULT];文件不存在
     * [recode: ReCode.OK];成功
     * **********************/
    def deleteFile() {
        def request = webUtilForRmpService.getRequest();
        def params = request.getParameterMap();
        //def session = webUtilForRmpService.getSession();
        //SimpleDateFormat sdfDate=new SimpleDateFormat("yyyy-MM-dd");
        //SimpleDateFormat sdfTime=new SimpleDateFormat("HH:mm:ss");
//        //检查网站可用性
//        def reInfo = shopService.getShopEnabled();
//        if (reInfo.recode != ReCode.OK) {
//            return reInfo;
//        }
        def idList = [];
        if (params.ids instanceof String) { //传入id
            //获取参数
            long id = com.lj.rmp.utils.Number.toLong(params.ids);//图片信息ID
            idList.add(id);
        } else if (params.ids instanceof String[]) {//传入id数组
            for (int i = 0; i < params.ids.length; i++) {
                Long id = com.lj.rmp.utils.Number.toLong(params.ids[i]);
                idList.add(id);
            }
        }

        def errors = "";
        def msgs = "";
        //查询出图片
        def resourceList = TpsResourceFileInfo.findAllByIdInList(idList);
        if (resourceList) {
            resourceList.each {
//                if (uploadFileService.delete(it.fileFullName)){
//                    it.delete(flush: true);
//                    log.info("资源文件[" + it + "]删除成功");
//                    msgs += "资源文件[" + it.fileName + "]删除成功<br/>";
//                }else{
//                    log.info("资源文件[" + it + "]删除失败");
//                    errors += "资源文件[" + it.fileName + "]删除失败<br/>";
//                }
                uploadFileService.delete(it.fileFullName);
                it.delete(flush: true);
                msgs += "资源文件[" + it.fileName + "]删除成功<br/>";
            }
            return [recode: ReCode.OK,msgs:msgs,errors:errors];
        } else {
            return [recode: ReCode.NO_RESULT];
        }
    }

    //获取资源文件URL
    String getUrl(def params) {
        def request = webUtilForRmpService.getRequest();
        //def params=request.getParameterMap();

        //防盗链处理
        String Referer = request.getHeader("Referer");
        String baseUrl = null;
//        def reInfo = shopService.getShopInfo();
//        if (ReCode.OK == reInfo.recode) {
//            baseUrl = reInfo.restaurantInfo?.baseUrl;
//        }
        if (baseUrl == null) {
            baseUrl = grailsApplication.config.grails.baseurls.baseUrl;
        }
        if (baseUrl == null || (Referer != null && Referer.indexOf(baseUrl) < 0)) {//盗链
            println("文件盗链");
            return null;
        }
        //根据ID查询出图片url
        String fileFullName = params.fileFullName;
        long id = com.lj.rmp.utils.Number.toLong(params.id);
        if (id > 0) {
            TpsResourceFileInfo resourceFileInfo = TpsResourceFileInfo.get(id);
            if (resourceFileInfo) {
                fileFullName = resourceFileInfo.fileFullName;
            }
        }
        String fileUrl = request.getContextPath() + "/" + fileFullName;
        return fileUrl;
    }
}
