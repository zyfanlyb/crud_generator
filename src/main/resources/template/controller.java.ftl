package ${package}.controller;

import ${package}.entity.${entity};
import ${package}.service.I${service};
import com.zyfan.pojo.web.RequestVo;
import com.zyfan.pojo.web.ResponseVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

/**
* ${table.comment!}
*
*/
@RestController
@RequestMapping("/${'${entity}' ? uncap_first}")
public class ${table.controllerName} {

    @Autowired
    private I${service} ${'${service}' ? substring(0) ? uncap_first};

    @PostMapping("/page")
    public ResponseVo<List<${entity}>> page(@RequestBody RequestVo<${entity}> requestVo) {
        return ResponseVo.success(${'${service}' ? substring(0) ? uncap_first}.pageList(requestVo));
    }

    @PostMapping("/insert")
    public ResponseVo insert(@RequestBody RequestVo<${entity}> requestVo) {
        ${'${service}' ? substring(0) ? uncap_first}.insert(requestVo);
        return ResponseVo.success();
    }

    @PostMapping("/update")
    public ResponseVo update(@RequestBody RequestVo<${entity}> requestVo) {
        ${'${service}' ? substring(0) ? uncap_first}.update(requestVo);
        return ResponseVo.success();
    }

    @PostMapping("/info/{id}")
    public ResponseVo<${entity}> info(@PathVariable("id") Long id) {
        return ResponseVo.success(${'${service}' ? substring(0) ? uncap_first}.info(id));
    }

    @PostMapping("/remove/{id}")
    public ResponseVo remove(@PathVariable("id") Long id) {
        ${'${service}' ? substring(0) ? uncap_first}.remove(id);
        return ResponseVo.success();
    }

}