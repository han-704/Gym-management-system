package com.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;

import com.interceptor.AuthorizationInterceptor;

@Configuration
public class InterceptorConfig extends WebMvcConfigurationSupport {
	
	// 视频文件夹路径，从配置文件读取
	@Value("${file.video-path:D:/gitcode/GymSystem-main/GymSystem-main/video}")
	private String videoPath;
	
	@Bean
    public AuthorizationInterceptor getAuthorizationInterceptor() {
        return new AuthorizationInterceptor();
    }
	
	@Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(getAuthorizationInterceptor())
            .addPathPatterns("/**")
            .excludePathPatterns("/static/**")
            .excludePathPatterns("/upload/**")
            .excludePathPatterns("/video/**")
            .excludePathPatterns("/jianshenxiangmu/download");
        super.addInterceptors(registry);
	}

	/**
	 * springboot 2.0配置WebMvcConfigurationSupport之后，会导致默认配置被覆盖，要访问静态资源需要重写addResourceHandlers方法
	 */
	@Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/**")
        .addResourceLocations("classpath:/resources/")
        .addResourceLocations("classpath:/static/")
        .addResourceLocations("classpath:/admin/")
        .addResourceLocations("classpath:/front/")
        .addResourceLocations("classpath:/public/");
		
		// 添加视频文件夹的静态资源映射
		registry.addResourceHandler("/video/**")
        .addResourceLocations("file:" + videoPath + "/");
		
		super.addResourceHandlers(registry);
    }
}
