package org.ranji.lemon.web.jersey.common.filter;

import java.io.IOException;

import javax.annotation.Priority;
import javax.ws.rs.Priorities;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerRequestFilter;
import javax.ws.rs.container.ContainerResponseContext;
import javax.ws.rs.container.ContainerResponseFilter;
import javax.ws.rs.ext.Provider;
import org.ranji.lemon.common.jersey.annotation.ResourceAccessToken;

@Provider
@ResourceAccessToken
@Priority(Priorities.USER)
public class AccessTokenFilter implements ContainerRequestFilter ,ContainerResponseFilter{
    @Override
    public void filter(ContainerRequestContext requestContext) throws IOException {
        System.out.println("访问请求日志过滤器执行了>>>>>>>>>>>>");
    }
    @Override
    public void filter(ContainerRequestContext requestContext, ContainerResponseContext responseContext) throws IOException {
        System.out.println("访问响应日志过滤器执行了>>>>>>>>>>>");
    }
}
