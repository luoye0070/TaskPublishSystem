import com.lj.csp.service.security.UserApiService
class BootStrap {
    def userApiService;
    def init = { servletContext ->
        userApiService.init();
    }
    def destroy = {
    }
}
