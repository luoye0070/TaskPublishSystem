package com.lj.tps.controller.front

import com.lj.constant.ReCode

class CommentController {
    def commentService;
    def index() {}

    def doTaskComment(){
      def reInfo=commentService.createTaskComment(params);
      if(reInfo.recode==ReCode.OK){
          flash.success="发表评论成功";
      }else{
          if(reInfo.recode==ReCode.SAVE_FAILED){
              flash.errors=reInfo.errors;
          }else{
              flash.errors=reInfo.recode.label;
          }
      }
      redirect(url: params.backUrl);
    }

}
