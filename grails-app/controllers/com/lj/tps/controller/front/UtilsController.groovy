package com.lj.tps.controller.front

class UtilsController {

    def index() {}

    def staticPage(){
        String viewName=params.vn;
        render(view: "/front/static/"+viewName);
    }
}
