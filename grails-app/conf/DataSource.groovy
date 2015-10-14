import org.springframework.core.io.ClassPathResource
import org.springframework.core.io.support.PropertiesLoaderUtils

def propertiesdef = PropertiesLoaderUtils.loadProperties(new ClassPathResource("datasource.properties"))
dataSource {
    pooled = true
    driverClassName = "org.h2.Driver"
    username = "sa"
    password = ""
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory'
}
// environment specific settings
environments {
    development {
        dataSource {
//            dbCreate = "create-drop" // one of 'create', 'create-drop', 'update', 'validate', ''
//            url = "jdbc:h2:mem:devDb;MVCC=TRUE;LOCK_TIMEOUT=10000"
            pooled = true
            driverClassName = "com.mysql.jdbc.Driver"
            username = "ljsj_2009"
            password = "ljgzs2009LJ"
            dialect = "org.hibernate.dialect.MySQLDialect"
            dbCreate = "update" // one of 'create', 'create-drop', 'update', 'validate', ''
            url = "jdbc:mysql://115.28.150.164:3306/tps_dev?useUnicode=true&autoreconnect=true&characterEncoding=UTF-8"
            logSql = true
        }
    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:h2:mem:testDb;MVCC=TRUE;LOCK_TIMEOUT=10000"
        }
    }
    production {
        dataSource {
            driverClassName = "com.mysql.jdbc.Driver"
            username = propertiesdef.getProperty("username");//"ljsj"
            password = propertiesdef.getProperty("password");
            dbCreate = "update" // one of 'create', 'create-drop', 'update', 'validate', ''
            url = propertiesdef.getProperty("url");//"jdbc:mysql://127.0.0.1:3306/piccxmcs?useUnicode=true&autoreconnect=true&characterEncoding=UTF-8"
            pooled = true
            properties {
               maxActive = -1
               minEvictableIdleTimeMillis=1800000
               timeBetweenEvictionRunsMillis=1800000
               numTestsPerEvictionRun=3
               testOnBorrow=true
               testWhileIdle=true
               testOnReturn=true
               validationQuery="SELECT 1"
            }
        }
    }
}
