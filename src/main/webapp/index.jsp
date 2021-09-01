<%--
  Created by IntelliJ IDEA.
  User: le
  Date: 2021/8/20
  Time: 15:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<html>
<head>
    <base href="<%=basePath%>">
    <title>Title</title>
    <script type="text/javascript" src="static/bootstrap-3.4.1-dist/js/jquery-3.4.1.min.js"></script>
    <script src="static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
    <link href="static/bootstrap-3.4.1-dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<!-- 搭建显示页面 -->
<div class="container">
    <!-- 标题 -->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!-- 员工修改的模态框 -->
    <div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">员工修改</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">empName</label>
                            <div class="col-sm-10">
                                <p class="form-control-static" id="emp_update_statice"></p>
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <input type="text" name="email" class="form-control" id="email_update_input"
                                       placeholder="email@atguigu.com">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender1_update_input" value="M"
                                           checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">deptName</label>
                            <div class="col-sm-4">
                                <!-- 部门提交部门id即可 -->
                                <select class="form-control" name="dId" id="dept_update"></select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="emp_update_btn">保存</button>
                </div>
            </div>
        </div>
    </div>
    <!-- 员工添加的模态框 -->
    <div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">员工添加</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">empName</label>
                            <div class="col-sm-10">
                                <input type="text" name="empName" class="form-control" id="empName_add_input"
                                       placeholder="empName">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <input type="text" name="email" class="form-control" id="email_add_input"
                                       placeholder="email@atguigu.com">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender1_add_input" value="M"
                                           checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">deptName</label>
                            <div class="col-sm-4">
                                <!-- 部门提交部门id即可 -->
                                <select class="form-control" name="dId" id="dept_add"></select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
                </div>
            </div>
        </div>
    </div>
    <!-- 按钮 -->
    <div class="row">
        <div class="col-md-4 col-md-offset-9">
            <button class="btn btn-primary" data-toggle="modal" id="emp_add_model_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_btn">删除</button>
        </div>
    </div>
    <!-- 显示表格数据 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="ckbox"/>
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>

    <!-- 显示分页信息 -->
    <div class="row">
        <!--分页文字信息  -->
        <div class="col-md-6" id="page_info_area"></div>
        <!-- 分页条信息 -->
        <div class="col-md-6" id="page_nav_area"></div>
    </div>

</div>
<script type="text/javascript">
    $(function () {
        to_page(1)
    })

    function to_page(pn) {
        $.ajax({
            url: "empList",
            data: "pn=" + pn,
            dataType: "json",
            type: "GET",
            success: function (result) {
                // console.log(result)
                //解析并显示员工数据
                build_emps_table(result);
                //解析并上传分页信息
                build_page_info(result);
                //解析并上传分页导航数据
                build_page_nav(result);
            }
        })
    }


    //分页导航
    function build_page_nav(result) {
        //清空数据
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        //前一页
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        //判断是否还有上一页
        if (!result.getExtend.pageInfo.hasPreviousPage) {
            //设置为不可点击
            firstPageLi.addClass("disabled")
            prePageLi.addClass("disabled")
        } else {
            $(firstPageLi).click(function () {
                to_page(1);
            });
            $(prePageLi).click(function () {
                to_page(result.getExtend.pageInfo.pageNum - 1)
            });

        }
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
        //判断是否还有下一页
        if (!result.getExtend.pageInfo.hasNextPage) {
            nextPageLi.addClass("disabled")
            lastPageLi.addClass("disabled")
        } else {
            $(nextPageLi).click(function () {
                to_page(result.getExtend.pageInfo.pageNum + 1);
            });
            $(lastPageLi).click(function () {
                to_page(result.getExtend.pageInfo.pages)
            });

        }
        ul.append(firstPageLi).append(prePageLi);
        //遍历输出分页页码
        $.each(result.getExtend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.getExtend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }
            //点击页码跳转
            $(numLi).click(function () {
                to_page(item);
            });
            ul.append(numLi);
        })
        ul.append(nextPageLi).append(lastPageLi);
        var nav = $("<nav></nav>").append(ul);
        nav.appendTo("#page_nav_area");
    }

    var totalRecord, currentPage;

    //分页信息
    function build_page_info(result) {
        //清空数据
        $("#page_info_area").empty();
        $("#page_info_area").append("当前" + result.getExtend.pageInfo.pageNum + "页,总"
            + result.getExtend.pageInfo.pages + "页,总"
            + result.getExtend.pageInfo.total + "条记录");
        totalRecord = result.getExtend.pageInfo.total;
        currentPage = result.getExtend.pageInfo.pageNum;
    }


    //员工数据
    function build_emps_table(result) {
        //清空数据
        $("#emps_table tbody").empty();
        var emps = result.getExtend.pageInfo.list;
        //遍历输出员工数据
        $.each(emps, function (index, item) {
            //员工信息
            var empBox = $("<td><input type='checkbox' class='checkbox-item'/></td>")
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == 'M' ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.dept.deptName);
            //按钮
            var editBtn = $("<button></button>").addClass("btn btn-primary edit_btn")
                .append($("<span></span>"))
                .addClass("glyphicon glyphicon-pencil").append("编辑");
            editBtn.attr("edit-id", item.empId);
            var delBtn = $("<button></button>").addClass("btn btn-danger")
                .append($("<span></span>"))
                .addClass("glyphicon glyphicon-trash").append("删除");
            delBtn.addClass("del-btn")
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>").append(empBox)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        });
    }

    function reset_form(ele) {
        $(ele)[0].reset();
        $(ele).find("*").removeClass("has-error has-success");
    }

    //获取部门信息
    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url: "dept",
            type: "GET",
            success: function (result) {
                // console.log(result);
                $.each(result.getExtend.depts, function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo(ele);
                })
            }
        })
    }

    //批量删除
    $("#emp_delete_btn").click(function () {
        empNum = $(".checkbox-item:checked").length;

        var empNames = "";
        var empIds = ""
        $.each($(".checkbox-item:checked"), function () {
            empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
            empIds += $(this).parents("tr").find("td:eq(1)").text() + "-";
        })
        //去除末尾的','和 '-'
        empNames = empNames.substring(0, empNames.length - 1);
        empIds = empIds.substring(0, empIds.length - 1);

        if (confirm("确定删除名为【" + empNames + "】的共【" + empNum + "】条记录吗")) {
            $.ajax({
                url: "emp/" + empIds,
                type: "DELETE",
                success: function (result) {
                    alert(result.msg)
                    to_page(currentPage);
                }
            })
        }
    })

    //点击弹出模态框
    $("#emp_add_model_btn").click(function () {
        getDepts("#empAddModal select");
        reset_form("#empAddModal form");
        $("#empAddModal").modal({
            //设置点击模态框之外不会返回
            backdrop: "static"
        });
    });


    //格式错误提示信息
    function validate_add_form(ele, status, msg) {
        $(ele).parent().removeClass("has-error has-success");
        $(ele).next("span").text("");
        if ("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        } else if ("success" == status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }
    }

    //验证员工信息格式是否正确
    function checkSaveEmpMsg() {
        var username = $("#empName_add_input").val();
        var email = $("#email_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;

        if (!regName.test(username)) {
            validate_add_form("#empName_add_input", "error", "用户名格式不正确")
            return false
        } else {
            validate_add_form("#empName_add_input", "success", "")
        }
        if (!regEmail.test(email)) {
            validate_add_form("#email_add_input", "error", "邮箱格式不正确")
            return false
        } else {
            validate_add_form("#email_add_input", "success", "")
        }
        return true;
    }

    //检查用户名是否重复
    $("#empName_add_input").change(function () {
        $.ajax({
            url: "checkUser",
            type: "POST",
            data: "empName=" + this.value,
            success: function (result) {
                if (result.code == 200) {
                    validate_add_form("#empName_add_input", "success", "用户名可用")
                    //自定义属性用于当用户名不可用时阻止提交
                    $("#emp_save_btn").attr("ajax-va", "success");
                } else {
                    validate_add_form("#empName_add_input", "error", result.getExtend.va_msg);
                    $("#emp_save_btn").attr("ajax-va", "error");
                }
            }
        });
    });

    //保存员工
    $("#emp_save_btn").click(function () {
        if (!checkSaveEmpMsg()) {
            return false;
        }
        if ($(this).attr("ajax-va") == "error") {
            return false;
        }
        $.ajax({
            url: "emp",
            type: "POST",
            data: $("#empAddModal form").serialize(),
            success: function (result) {
                if (result.code == 200) {
                    //保存成功关闭模态框
                    $("#empAddModal").modal('hide');
                    //跳转到最后一页
                    to_page(totalRecord);
                } else {
                    // console.log(result)
                    if (undefined != result.getExtend.errorField.empName) {
                        //显示员工姓名错误信息
                        validate_add_form("#empName_add_input", "error", result.getExtend.errorField.empName)
                    }
                    if (undefined != result.getExtend.errorField.email) {
                        //显示邮箱错误信息
                        validate_add_form("#email_add_input", "error", result.getExtend.errorField.email)
                    }
                }
            }
        });
    });

    function getEmp(id) {
        $.ajax({
            url: "emp/" + id,
            type: "GET",
            success: function (result) {
                // console.log(result)
                var empDate = result.getExtend.emp;
                $("#emp_update_statice").text(empDate.empName);
                $("#email_update_input").val(empDate.email);
                $("#empUpdateModal input[name=gender]").val([empDate.gender]);
                $("#empUpdateModal select").val([empDate.dId]);
            }
        })
    }

    //更新员工
    $(document).on("click", ".edit_btn", function () {
        //获取部门信息
        getDepts("#empUpdateModal select");
        //获取员工信息
        getEmp($(this).attr("edit-id"));
        $("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"))
        $("#empUpdateModal").modal({
            backdrop: "static"
        });
    });

    //保存员工
    $("#emp_update_btn").click(function () {
        //验证修改信息
        var email = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;

        if (!regEmail.test(email)) {
            validate_add_form("#email_update_input", "error", "邮箱格式不正确")
            return false
        } else {
            validate_add_form("#email_update_input", "success", "")
        }

        $.ajax({
            url: "emp/" + $('#emp_update_btn').attr("edit-id"),
            type: "PUT",
            data: $("#empUpdateModal form").serialize(),
            success: function (result) {
                // console.log(result.msg)
                $("#empUpdateModal").modal("hide");
                to_page(currentPage);
            }
        })

    })

    //删除单个
    //给删除按钮绑定单机事件
    $(document).on("click", ".del-btn", function () {
        var empId = $(this).parents("tr").find("td:eq(1)").text();
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        if (confirm("确认删除【" + empName + "】吗")) {
            $.ajax({
                url: "emp/" + empId,
                type: "DELETE",
                success: function (result) {
                    to_page(currentPage);
                }
            })
        }
    })

    //全选框
    $(document).on("click", "#ckbox", function () {
        //全选
        $(".checkbox-item").prop("checked", $(this).prop("checked"));
    })

    $(document).on("click", ".checkbox-item", function () {
        var flag = $(".checkbox-item:checked").length == 5;
        if (flag) {
            $("#ckbox").prop("checked", flag);
        } else {
            $("#ckbox").prop("checked", flag);
        }
    })


</script>
</body>
</html>