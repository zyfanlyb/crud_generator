package com.zyfan.generator;

import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.generator.FastAutoGenerator;
import com.baomidou.mybatisplus.generator.engine.FreemarkerTemplateEngine;
import org.springframework.boot.Banner;
import org.springframework.boot.WebApplicationType;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.context.ApplicationContext;
import org.springframework.core.env.Environment;

import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class CodeGenerator {

    public static void main(String[] args) {
        ApplicationContext context = new SpringApplicationBuilder(CodeGenerator.class)
                .web(WebApplicationType.NONE)
                .bannerMode(Banner.Mode.OFF)
                .run(args);
        Environment environment = context.getEnvironment();
        String jdbcUrl = environment.getProperty("spring.datasource.dynamic.datasource.master.url");
        String jdbcUsername = environment.getProperty("spring.datasource.dynamic.datasource.master.username");
        String jdbcPassword = environment.getProperty("spring.datasource.dynamic.datasource.master.password");
        String packageName = "com.zyfan.generator";
        System.out.println("输入包名:");
        Scanner scanner = new Scanner(System.in);
        String subPackageName = scanner.nextLine();
        System.out.println("输入表名(多表名逗号分隔):");
        String tableNames = scanner.nextLine();
        for (String tableName : tableNames.replaceAll(" ", "").split(",")) {
            FastAutoGenerator.create(jdbcUrl, jdbcUsername, jdbcPassword)
                    .globalConfig(builder -> builder
                            .outputDir(Paths.get(System.getProperty("user.dir")) + "/src/main/java")
                            .disableOpenDir()
                    )
                    .packageConfig(builder -> builder
                            .parent(packageName + "." + subPackageName)
                            .entity("entity")
                            .mapper("mapper")
                            .service("service")
                            .serviceImpl("service.impl")
                            .xml("mapper.xml")
                    )
                    .strategyConfig(builder -> builder
                            .addInclude(tableName)
                            .entityBuilder().javaTemplate("template/entity.java").build()
                            .mapperBuilder().mapperTemplate("template/mapper.java").mapperXmlTemplate("template/mapper.xml").build()
                            .serviceBuilder().serviceTemplate("template/service.java").serviceImplTemplate("template/serviceImpl.java").build()
                            .controllerBuilder().template("template/controller.java").build()
                    )
                    .injectionConfig(builder -> {
                        Map<String, Object> metadata = new HashMap<>();
                        metadata.put("package", packageName + "." + subPackageName);
                        String entityName = tableName.substring(0, 1).toUpperCase() + StringUtils.underlineToCamel(tableName).substring(1);
                        metadata.put("entity", entityName);
                        metadata.put("mapper", entityName + "Mapper");
                        metadata.put("service", entityName + "Service");
                        metadata.put("serviceImpl", entityName + "ServiceImpl");
                        metadata.put("controller", entityName + "Controller");
                        metadata.put("logicDeleteFieldName", "deleted");
                        builder.customMap(metadata);
                    })
                    .templateEngine(new FreemarkerTemplateEngine())
                    .execute();
        }
    }
}
