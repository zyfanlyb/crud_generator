package ${package}.service;

import ${package}.entity.${entity};
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.zyfan.pojo.web.RequestVo;

public interface I${service} extends IService<${entity}> {

    IPage<${entity}> pageList(RequestVo<${entity}> requestVo);

    void insert(RequestVo<${entity}> requestVo);

    void update(RequestVo<${entity}> requestVo);

    ${entity} info(Long id);

    void remove(Long id);

}