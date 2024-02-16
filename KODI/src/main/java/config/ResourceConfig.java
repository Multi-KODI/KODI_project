package config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class ResourceConfig implements WebMvcConfigurer {

	private String connectPath = "/image/**";
	private String resourcePath = "file:///FullStack/\\ud30c\\uc774\\ub110\\u0020\\ud504\\ub85c\\uc81d\\ud2b8/image";

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler(connectPath).addResourceLocations(resourcePath);
	}
}
