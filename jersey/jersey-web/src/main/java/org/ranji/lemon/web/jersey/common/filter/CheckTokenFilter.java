package org.ranji.lemon.web.jersey.common.filter;

import java.io.IOException;

import javax.annotation.Priority;
import javax.ws.rs.Priorities;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerRequestFilter;
import javax.ws.rs.container.ContainerResponseContext;
import javax.ws.rs.container.ContainerResponseFilter;
import javax.ws.rs.ext.Provider;
import org.ranji.lemon.web.jersey.common.annotation.CheckAccessToken;

@Provider					//-- 过滤器
@CheckAccessToken			//-- 和@CheckAccessToken标注绑定，含有该标注的类或方法即会调用该过滤器
@Priority(Priorities.USER)	//-- 设置过滤器的优先级，就是个long整形
public class CheckTokenFilter implements ContainerRequestFilter ,ContainerResponseFilter{
    @Override
    public void filter(ContainerRequestContext requestContext) throws IOException {
    	//int i = 1;
    	//if(i==1)throw new TokenException();
        //-- System.out.println("访问请求过滤器执行>>>>>>>>>>>>");
    }
    @Override
    public void filter(ContainerRequestContext requestContext, ContainerResponseContext responseContext) throws IOException {
    	responseContext.getHeaders().add("Access-Control-Allow-Origin", "*");
        //-- System.out.println("访问响应过滤器执行>>>>>>>>>>>");
    }
}
