/**
 * Created by lixiao on 16/6/1.
 */
$(function () {
    var vuescho = new Vue({
        el: '#vueroot',
        data: {
            schools: [

            ]
        }
    })
    $(".search-input").on("input",function () {
        var inputVal = $(".search-input").val().trim();
        if(inputVal != ''){
            $(".initdata").hide();
            $.post("/user/findSchool.action",{'isbn':inputVal},function (data) {
                if(data!=''){
                    vuescho.$data.schools=data;
                }

            })

        }else {
            vuescho.$data.schools = '';
            $(".initdata").show();
        }
    })



})
