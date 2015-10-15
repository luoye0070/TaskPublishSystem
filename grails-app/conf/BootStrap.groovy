import com.lj.csp.service.security.UserApiService
class BootStrap {
    def userApiService;
    def systemInitService;
    def init = { servletContext ->
        userApiService.init();
        systemInitService.init();
    }
    def destroy = {
    }
}
