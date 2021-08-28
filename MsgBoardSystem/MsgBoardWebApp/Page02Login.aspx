﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Page02Login.aspx.cs" Inherits="MsgBoardWebApp.Page02Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form class="row g-3 needs-validation" novalidate>
        <h2>會員登入</h2>
        <div class="row mb-3">
            <div class="col-2 text-center">
                <label for="txtAcc" class="form-label">帳號 : </label>
            </div>
            <div class="col-4">
                <input type="text" class="form-control" id="txtAcc" value="" required>
                <div class="invalid-feedback">
                    請填入帳號!
                </div>
            </div>
        </div>
        <div class="row mb-3">
            <div class="col-2 text-center">
                <label for="txtPwd" class="form-label">密碼 : </label>
            </div>
            <div class="col-4">
                <input type="password" class="form-control" id="txtPwd" value="" required>
                <div class="invalid-feedback">
                    請填入密碼!
                </div>
            </div>
        </div>
        <div class="col-12">
            <button class="btn btn-primary" type="submit" data-bs-toggle="modal" data-bs-target="#noticeModal">送出</button>
            <a class="btn btn btn-outline-info" type="button" href="Page021ForgetPW.aspx">忘記密碼</a>
            <input class="btn btn-warning" type="reset" value="登出" id="logoutBtn">
        </div>
        <hr class="my-4">
    </form>

    <!-- Modal -->
    <div class="modal fade" id="noticeModal" tabindex="-1" aria-labelledby="noticeModalLable" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="noticeModalLable">提示訊息</h5>
            <button type="button" class="btn-close closeBtn" data-bs-dismiss="modal" aria-label="Close" ></button>
          </div>
          <div class="modal-body">
            <p id="modelText"></p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary closeBtn" data-bs-dismiss="modal" >Close</button>
          </div>
        </div>
      </div>
    </div>

    <script>
        (function () {
            'use strict'

            var forms = document.querySelectorAll('.needs-validation')
            var redirect = function () {
                window.location.href = "http://localhost:49461/Page04PostingHall.aspx";
            }

            Array.prototype.slice.call(forms).forEach(function (form) {
                form.addEventListener('submit', function (login) {
                    if (!form.checkValidity()) {
                        event.preventDefault()
                        event.stopPropagation()
                    }
                    else {
                        var acc = $("#txtAcc").val();
                        var pwd = $("#txtPwd").val();
                        event.preventDefault()
                        $.ajax({
                            url: "http://localhost:49461/Handler/SystemHandler.ashx?ActionName=Login",
                            type: "POST",
                            data: {
                                "Account": acc,
                                "Password": pwd
                            },
                            success: function (result) {                                
                                var authx = document.cookie.indexOf(".ASPXAUTH");
                                if ("Success" == result) {
                                    $("#modelText").text("登入成功!");
                                    if (authx == 0) {
                                        $(".closeBtn").click(function () {
                                            $('#funcList').show();
                                            redirect();
                                        });
                                    }
                                    else {
                                        alert("Auth cookie fail");
                                        $("#modelText").text(result);
                                    }
                                }
                                else {
                                    $('#funcList').hide();
                                    $("#modelText").text(result);
                                }
                            }
                        });
                    }
                    form.classList.add('was-validated')
                }, false)
                form.addEventListener('reset', function (resetEvn) {
                    document.cookie = '.ASPXAUTH' + '=; expires=Thu, 01-Jan-70 00:00:01 GMT;';
                    alert("登出成功");
                    window.location.href = "http://localhost:49461/Page01Default.aspx";
                }, false)
            });
        })()
    </script>
</asp:Content>
