package com.ssm.controller;

import com.ssm.domain.Dept;
import com.ssm.serivce.DeptService;
import com.ssm.vo.CommonResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DeptController {

    @Autowired
    private DeptService deptService;

    @RequestMapping("/dept")
    @ResponseBody
    public CommonResult getDepts(){
        List<Dept> depts = deptService.queryDepts();
        return CommonResult.success().add("depts",depts);
    }

}
