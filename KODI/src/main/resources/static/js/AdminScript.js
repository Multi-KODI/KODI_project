$(document).ready(function () {

    var deleteButtons = document.querySelectorAll('.deletebtn');

    deleteButtons.forEach(function (deleteButton) {
        deleteButton.addEventListener('click', function () {
            var postIdx = parseInt(deleteButton.dataset.postIdx); // 문자열을 숫자로 변환
            var data = {
                postIdx: postIdx
            };

            fetch('http://localhost:7777/api/admin/deletepost', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    // You can add more headers if needed
                },
                body: JSON.stringify(data) // 데이터를 JSON 문자열로 변환하여 전송
            })
                .then(() => {
                    location.href = 'http://localhost:7777/api/admin/allposts';
                })
                .catch(error => console.error('Error:', error));
        });
    });


    function updateMenuContentPosition() {
        var menuOffset = $(".menu").offset();
        $(".menu-content").css({ 'left': menuOffset.left });
    }

    //관리자 메뉴버튼
    $("#menubtn").on("click", function () {
        updateMenuContentPosition();
        $(".menu-content").slideToggle(); // 
    });

    $(window).on('resize', function () {
        if ($(".menu-content").is(":visible")) {
            updateMenuContentPosition();
        }
    });

    $("#logoutbtn").on("click", function () {
        if (confirm("로그아웃 하시겠습니까?")) {
            window.location.href = "/start";
        } else {
        }
    });

}); //ready