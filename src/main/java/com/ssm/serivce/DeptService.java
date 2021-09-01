package com.ssm.serivce;

import com.ssm.dao.DeptMapper;
import com.ssm.domain.Dept;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DeptService {

    @Autowired
    private DeptMapper deptMapper;

    public List<Dept> queryDepts(){
        return deptMapper.selectByExample(null);
    }

}
