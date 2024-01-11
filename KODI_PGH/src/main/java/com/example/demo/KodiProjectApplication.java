package com.example.demo;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@ComponentScan(basePackages = "dto")
@ComponentScan(basePackages = "dao")
@ComponentScan(basePackages = "service")
@ComponentScan(basePackages = "controller")
@MapperScan(basePackages = "dao")
@MapperScan(basePackages = "config")
@SpringBootApplication
public class KodiProjectApplication {

	public static void main(String[] args) {
		SpringApplication.run(KodiProjectApplication.class, args);
		System.out.println("=======부트 시작=======");
	}

}
