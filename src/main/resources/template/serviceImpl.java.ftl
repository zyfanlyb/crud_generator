package ${package}.service.impl;

import ${package}.entity.${entity};
import ${package}.mapper.${mapper};
import ${package}.service.I${service};
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.zyfan.pojo.web.RequestVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ${service}Impl extends ServiceImpl<${mapper},${entity}> implements I${service} {

    @Autowired
    private ${mapper} ${'${mapper}' ? uncap_first};

    @Override
    public IPage<${entity}> pageList(RequestVo<${entity}> requestVo) {
        return ${'${mapper}' ? uncap_first}.selectPage(new Page<>(requestVo.getPageNum(), requestVo.getPageSize()),
            Wrappers.lambdaQuery(${entity}.class)
        );
    }

    @Override
    public void insertOrUpdate(RequestVo<${entity}> requestVo) {
        ${'${mapper}' ? uncap_first}.insertOrUpdate(requestVo.getData());
    }

    @Override
    public ${entity} info(Long id) {
        return ${'${mapper}' ? uncap_first}.selectById(id);
    }

    @Override
    public void remove(Long id) {
        ${'${mapper}' ? uncap_first}.deleteById(id);
    }
}