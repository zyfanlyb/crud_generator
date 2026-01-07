package ${package}.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * ${table.comment!}
 */
@Data
@TableName("${table.name}")
public class ${entity} {

<#list table.fields as field>
<#if field.keyFlag>
    <#assign keyPropertyName="${field.propertyName}"/>
</#if>
<#if field.comment!?length gt 0>
    /**
    * ${field.comment}
    */
</#if>
<#if field.keyFlag>
<#-- 主键 -->
    <#if field.keyIdentityFlag>
    @TableId(value = "${field.annotationColumnName}", type = IdType.AUTO)
    <#elseif idType??>
    @TableId(value = "${field.annotationColumnName}", type = IdType.${idType})
    <#elseif field.convert>
    @TableId("${field.annotationColumnName}")
    </#if>
<#-- 普通字段 -->
</#if>
    <#if field.propertyType == "Date">
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    </#if>
    @TableField("${field.annotationColumnName}")
<#-- 逻辑删除注解 -->
<#if (logicDeleteFieldName!"") == field.name>
    @TableLogic
</#if>
    private ${field.propertyType} ${field.propertyName};

</#list>
}
