package com.pullreports.example;

import jakarta.servlet.*;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

import java.io.IOException;

public class DemoSitemeshFilter extends ConfigurableSiteMeshFilter {
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
		FilterChain chain) throws IOException, ServletException {
		if ("map".equals(request.getParameter("format"))) {
			request.setAttribute("decorator.name", "/WEB-INF/decorators/export-map-theme.jsp");
		} else if ("html".equals(request.getParameter("format")) ||
				"htmltree".equals(request.getParameter("format"))) {
			request.setAttribute("decorator.name", "/WEB-INF/decorators/export-theme.jsp");
		}
		super.doFilter(request, response, chain);
	}
}
