{include file='admin/main.tpl'}

<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/jsonform@2.2.5/deps/opt/bootstrap.min.css" />

<main class="content">
    <div class="content-header ui-content-header">
        <div class="container">
            <h1 class="content-heading">设置中心</h1>
        </div>
    </div>

    <div class="container">
        <div class="col-xx-12 col-sm-12">
            <div class="card quickadd">
                <div class="card-main">
                    <div class="card-inner">
                        <form></form>
                    </div>
                </div>
            </div>
        </div>
        {include file='dialog.tpl'}
    </div>
</main>

{include file='admin/footer.tpl'}

<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/jsonform@2.2.5/deps/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/jsonform@2.2.5/deps/underscore.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/jsonform@2.2.5/deps/opt/jsv.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/jsonform@2.2.5/lib/jsonform.min.js"></script>
<script type="text/javascript">
$('form').jsonForm({
    schema: {
        name: {
            type: 'string',
            title: 'Name',
            required: true
        },
        age: {
            type: 'number',
            title: 'Age'
        },
    },
    "form": [
        "*",
        {
          "type": "submit",
          "title": "提交"
        } 
    ],
    onSubmit: function (errors, values) {
        $.ajax({
            type: "POST",
            url: "/admin/setting",
            dataType: "json",
            data: {
                class: 'f2f_pay',
                f2f_pay_app_id: $$getValue('f2f_pay_app_id'),
                f2f_pay_pid: $$getValue('f2f_pay_pid'),
                f2f_pay_public_key: $$getValue('f2f_pay_public_key'),
                f2f_pay_private_key: $$getValue('f2f_pay_private_key'),
                f2f_pay_notify_url: $$getValue('f2f_pay_notify_url')
            },
            success: data => {
                $("#result").modal();
                $$.getElementById('msg').innerHTML = data.msg;
                if (data.ret) {
                    window.setTimeout("location.href='/admin/setting'", {$config['jump_delay']});
                }
            },
            error: jqXHR => {
                alert(`发生错误：${
                        jqXHR.status
                        }`);
            }
        })
    }
});
</script>