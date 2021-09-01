package com.ssm.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.domain.Employee;
import com.ssm.serivce.EmployeeService;
import com.ssm.vo.CommonResult;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {

    @Resource
    private EmployeeService employeeService;


    /**
     * 删除员工/批量删除员工
     *
     * @param ids
     * @return
     */
    @DeleteMapping("/emp/{ids}")
    @ResponseBody
    public CommonResult deleteEmp(@PathVariable String ids) {
        //批量删除
        if (ids.contains("-")) {
            //把ids用 - 分割
            String[] str_ids = ids.split("-");
            List<Integer> del_ids = new ArrayList<>();
            for (String str_id : str_ids) {
                del_ids.add(Integer.parseInt(str_id));
            }
            employeeService.deleteBatch(del_ids);
        } else {
            //删除单条
            Integer id = Integer.parseInt(ids);
            employeeService.deleteById(id);
        }
        return CommonResult.success();
    }

    /**
     * 更新员工
     *
     * @param employee
     * @return
     */
    @PutMapping("/emp/{empId}")
    @ResponseBody
    public CommonResult updateEmp(Employee employee) {
        int i = employeeService.updateEmp(employee);
        return CommonResult.finalResult(i);
    }


    @GetMapping("/emp/{id}")
    @ResponseBody
    public CommonResult getEmp(@PathVariable("id") Integer id) {
        Employee emp = employeeService.getEmp(id);
        return CommonResult.success().add("emp", emp);
    }


    /**
     * 校验用户信息
     *
     * @param empName
     * @return
     */
    @RequestMapping("/checkUser")
    @ResponseBody
    public CommonResult checkUser(@RequestParam("empName") String empName) {
        //判断用户名是否合法
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
        if (!empName.matches(regx)) {
            System.out.println(empName.matches(regx));
            return CommonResult.fail().add("va_msg", "用户名只能是6-16位数字和字母的组合或者2-5位中文");
        }
        //用户名合法，验证用户名是否存在
        boolean result = employeeService.checkUser(empName);
        if (result) {
            return CommonResult.success();
        }
        return CommonResult.fail().add("va_msg", "用户名已存在");
    }

    /**
     * 保存员工
     *
     * @param employee
     * @return
     */
    @PostMapping("/emp")
    @ResponseBody
    public CommonResult addEmp(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()) {
            Map<String, String> map = new HashMap<>();
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError fieldError : fieldErrors) {
                System.out.println("错误信息的字段名" + fieldError.getField());
                System.out.println("错误信息" + fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return CommonResult.fail().add("errorField", map);
        } else {
            System.out.println("========================================");
            employeeService.insertEmpDATA(employee);
            return CommonResult.success();
        }

    }


    /**
     * 分页查询
     * 使用json
     *
     * @param pn 当前页码
     * @return 分页数据
     */
    @RequestMapping("/empList")
    @ResponseBody
    public CommonResult getEmpListWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        //pn 传入的页码
        //pageSize每页大小
        PageHelper.startPage(pn, 5);
        List<Employee> employeeList = employeeService.getAll();
        //封装了详细的分页数据，传入连续显示页数
        PageInfo<Employee> employeePageInfo = new PageInfo<>(employeeList, 5);
        return CommonResult.success().add("pageInfo", employeePageInfo);
    }

    /**
     * 分页查询
     *
     * @return
     */
//    @RequestMapping("/emps")
    public ModelAndView getEmpList(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        ModelAndView mv = new ModelAndView();
        //pn 传入的页码
        //pagesize每页大小
        PageHelper.startPage(pn, 5);
        List<Employee> employeeList = employeeService.getAll();
        //封装了详细的分页数据，传入连续显示页数
        PageInfo<Employee> employeePageInfo = new PageInfo<>(employeeList, 5);
        mv.addObject("pageInfo", employeePageInfo);
        mv.setViewName("pageList");
        return mv;
    }

}
