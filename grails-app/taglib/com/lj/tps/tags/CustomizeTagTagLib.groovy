package com.lj.tps.tags

import com.lj.rmp.data.ResourceFileInfo
import com.lj.rmp.enumcustom.ResourceType

class CustomizeTagTagLib {

    static namespace = "tps";

    Closure resourceFilePreview = { attrs ->
        def writer = out
        String htmlStr = "";
        long id = com.lj.rmp.utils.Number.toLong(attrs.id);
        int width = com.lj.rmp.utils.Number.toInteger(attrs.width);
        if (width == 0) {
            width = 100;
        }
        int height = com.lj.rmp.utils.Number.toInteger(attrs.height);
        if (height == 0) {
            height = 100;
        }
        if (attrs.id == null) {
            throwTagError("Tag [paginate] is missing required attribute [total]")
        }
        ResourceFileInfo resourceFileInfo = ResourceFileInfo.get(id);
        if (resourceFileInfo) {
            if (resourceFileInfo.type == ResourceType.IMAGE.code) {
                htmlStr = "<img src='" + request.getContextPath() + "/uploadFile/" + resourceFileInfo.fileFullName + "' width='" + width + "' height='" + height + "'/>";
            } else if (resourceFileInfo.type == ResourceType.FLASH.code||resourceFileInfo.type == ResourceType.MEDIA.code) {
                String contentStr = "<iframe id=\"iframe" + resourceFileInfo.id + "\" src=\"" + createLink(controller: "tpsResourceFile", action: "previewFlash") + "?id=" + resourceFileInfo.id + "\"" +
                        "width=500 height=300></iframe>";
                htmlStr = "<input type='button' id=\"btnShow" + resourceFileInfo.id + "\" value='预览'/>" +
                        "<script type=\"text/javascript\">\n" +
                        " BUI.use('bui/overlay',function(Overlay){\n" +
                        "     \$('#btnShow" + resourceFileInfo.id + "').on('click',function () {\n" +
                        "           var dialog" + resourceFileInfo.id + " = new Overlay.Dialog({\n" +
                        "               title:'预览-" + resourceFileInfo.fileName + "',\n" +
                        "               width:550,\n" +
                        "               height:360,\n" +
                        "               mask:false,\n" +
                        "               closeAction : 'destroy', //每次关闭dialog释放\n" +
                        "               buttons:[],\n" +
                        "               bodyContent:'" + contentStr + "'\n" +
                        "           });\n" +
                        "          dialog" + resourceFileInfo.id + ".show();\n" +
                        "     });\n" +
                        " });\n" +
                        " </script>";
            } else {
                htmlStr = "<a href='" + request.getContextPath() + "/uploadFile/" + resourceFileInfo.fileFullName + "'>" + resourceFileInfo.fileName + "</a>";
            }
        }
        writer << htmlStr;
    }
}
