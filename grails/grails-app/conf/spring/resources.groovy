import org.springframework.boot.web.servlet.ServletRegistrationBean
import org.springframework.boot.web.servlet.ServletListenerRegistrationBean
import com.pullreports.web.PullReportsServlet
import com.pullreports.web.PullReportsContextListener
import grails.util.Environment

beans = {

    if (Environment.isDevelopmentMode()) {
        tomcatServletWebServerFactory(com.pullreports.qs.grails.JndiTomcatServletWebServerFactory)
    }

    pullreportsListener(ServletListenerRegistrationBean) { bean ->
         listener = new PullReportsContextListener()
    }

    pullreportsServlet(ServletRegistrationBean) { bean ->
         servlet = new PullReportsServlet()
         urlMappings = ['/pullreports/*']
    }
}
