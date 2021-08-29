﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Page04PostingHall.aspx.cs" Inherits="MsgBoardWebApp.Page04PostingHall" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="DataTableFrame/DataTables-1.10.25/css/dataTables.bootstrap5.min.css" />
    <script src="DataTableFrame/DataTables-1.10.25/js/jquery.dataTables.min.js"></script>
    <script src="DataTableFrame/DataTables-1.10.25/js/dataTables.bootstrap5.min.js"></script>
    <script>
        $(document).ready(function () {
            var table = $('#PostTable').DataTable();

            // set page form            
            function AddRow(obj) {
                table.row.add([
                    `<a href="http://localhost:49461/Page05PostMsg.aspx?PID=${obj.PostID}">${obj.Title}<a>`,
                    obj.Name,
                    obj.CreateDate
                ]).draw(false);
            };

            /*
            var adminPostHtml =
                `<a href="Page05PostMsg.aspx?PID=${obj.PostID}" class="list-group-item list-group-item-action list-group-item-info" aria-current="true">
                        <div class="d-flex w-100 justify-content-between">
                            <h5 class="mb-1">管理員公告</h5>
                            <small class="text-muted">建立時間: ${obj.CreateDate}</small>
                        </div>
                        <p class="mb-1">${obj.Title}</p>
                        <small>點擊前往頁面...</small>
                    </a>`;
            */

            //Get all post's information
            $.ajax({
                url: "http://localhost:49461/Handler/SystemHandler.ashx?ActionName=GetAllPost",
                type: "GET",
                data: {},
                success: function (result) {
                    var AdminPost = "<hr>";
                    for (var i = 0; i < result.length; i++) {
                        var obj = result[i];
                        if ("Member" == obj.Level) { AddRow(obj); }
                        else if ("Admin" == obj.Level) {
                            AdminPost +=
                                `<a href="Page05PostMsg.aspx?PID=${obj.PostID}" class="list-group-item list-group-item-action list-group-item-info" aria-current="true">
                                    <div class="d-flex w-100 justify-content-between">
                                        <h5 class="mb-1">! 管理員公告 !</h5>
                                        <small class="text-muted">建立時間: ${obj.CreateDate}</small>
                                    </div>
                                    <p class="mb-1 fw-bold">${obj.Title}</p>
                                    <small>點擊前往頁面...</small>
                                </a>`;
                        }
                    }
                    $("#adminListBody").append(AdminPost);
                }
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <p class="fs-2 fw-bold">貼文區</p>
        <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="Page01Default.aspx">首頁</a></li>
                <li class="breadcrumb-item active" aria-current="page">貼文區</li>
            </ol>
        </nav>
    </div>
    <div class="list-group" id="adminListBody"><!--公告放這裡--></div>
    <hr class="my-4">
    <table id="PostTable" class="table table-striped table-bordered table-sm table-hover" cellspacing="0" width="100%">
        <thead>
            <tr>
                <th class="th-sm">標題</th>
                <th class="th-sm">發文者</th>
                <th class="th-sm">建立時間</th>
            </tr>
        </thead>
        <tfoot>
            <tr>
                <th>標題</th>
                <th>發文者</th>
                <th>建立時間</th>
            </tr>
        </tfoot>
    </table>
    <hr class="my-4">
    <form runat="server" id="page04form" visible="false">
        <p>測試用字串</p>
        <asp:Literal runat="server" ID="ltlMsg"></asp:Literal><br />
    </form>
    <script src="Bootstrap/js/bootstrap.bundle.min.js"></script>
</asp:Content>
