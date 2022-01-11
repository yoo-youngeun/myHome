function sendit() {

    //정규식
    const expIdText = RegExp(/^[A-Za-z]+$/);
    const expNameText = RegExp(/[가-힣]+$/);
    const expHpText = RegExp(/^\d{3}-\d{3,4}-\d{4}$/);
    const expEmailText = RegExp(/^[A-Za-z0-9\.\-]+@[A-Za-z0-9\.\-]+\.+[A-za-z0-9]+$/);

    if(!($('#userid').val())) {
        alert('아이디를 입력하세요');
        $('#userid').focus();
        return false;
    }

    if($('#userid').val().length < 4 || $('#userid').val().length > 20){
        alert(`아이디 형식을 확인하세요\n영문 4-20자 사이로 입력해주세요.`);
        $('#userid').focus();
        return false;
    }

    if(!expIdText.test($('#userid').val())) {
        alert(`아이디 형식을 확인하세요\n영문 4-20자 사이로 입력해주세요.`);
        $('#userid').focus();
        return false;
    }

    if(!($('#userpw').val())) {
        alert('패스워드를 입력하세요');
        $('#userpw').focus();
        return false;
    }

    if(($('#userpw').val().length < 4 || $('#userpw').val().length > 20)){
        alert(`비밀번호 형식을 확인하세요\n4-20자 사이로 입력해주세요.`);
        $('#userpw').focus();
        return false;
    }

    if(($('#userpw').val()) != ($('#userpw_re').val())) {
        alert('비밀번호가 다릅니다.');
        $('#userpw').focus();
        return false;
    }

    if(!($('#name').val())) {
        alert('이름을 입력하세요');
        nam$('#name').focus();
        return false;
    }

    if(!expNameText.test($('#name').val())) {
        alert('이름형식을 다시 확인해주세요\n한글만 입력가능합니다.');
        $('#name').focus();
        return false;
    }

    if(!($('#hp').val())){
        alert('휴대폰번호를 입력하세요');
        $('#hp').focus();
        return false;
    }

    if(!expHpText.test($('#hp').val())) {
        alert('휴대폰번호 형식을 다시 확인해주세요\n하이픈(-)을 포함해야합니다.');
        $('#hp').focus();
        return false;
    }

    if($('#isssn').val() == 'n') {
        alert('주민등록번호 확인 버튼을 눌러주세요');
        return false;
    }

    if(!($('#sample6_postcode').val())) {
        alert('우편번호를 입력하세요');
        return false;
    }

    if(!($('#sample6_address').val())) {
        alert('주소를 입력하세요');
        return false;
    }

    if(!($('#sample6_detailAddress').val())) {
        alert('상세주소를 입력하세요');
        return false;
    }

    let isHobby = false;

    for(let i=0; i < $('[name="hobby"]').length; i++) {
        if(($('option[name="hobby"]').eq(i).is(":selected")) == true){
            isHobby = true;
            break;
        }
    }
    if(!isHobby){
        alert('취미를 선택하세요');
        return false;
    }

    let isHint = false;

    for(let i=0; i < $('[name="hint"]').length; i++) {
        if($("option[name='hint']").eq(i).is(":selected") == true){
            isHint = true;
            break;
        }
    }
    if(!isHint) {
        alert('비밀번호 힌트를 선택하세요');
        return false;
    }

    if(!($('#pwhint').val())){
        alert('비밀번호 힌트 답을 입력하세요');
        return false;
    }

    if(!($('#email').val())){
        alert('이메일을 입력하세요');
        return false;
    }

    if(!expEmailText.test('#email').val()){
        alert('이메일 형식을 확인하세요')
        return false;
    }


    return true;
}

$(function(){
    $("#ssn1").on('keyup', function(){
        if($(this).val().length >= 6){
            $("#ssn2").focus();
        }
    });

    $("#ssn1, #ssn2").on('keypress', function(){
        $('#isssn').val('n');
    });

    $("#ssn1, #ssn2").on('keyup', function(){
        const ssn = $('#ssn1').val() + $('#ssn2').val();
        const s1 = Number(ssn.substr(0, 1));
        const s2 = Number(ssn.substr(1, 1));
        const s3 = Number(ssn.substr(2, 1));
        const s4 = Number(ssn.substr(3, 1));
        const s5 = Number(ssn.substr(4, 1));
        const s6 = Number(ssn.substr(5, 1));
        const s7 = Number(ssn.substr(6, 1));
    
        let fY = 19;
        let year = "1900";
    
        if(s7 >= 3 || s1 <= 2) {
            fY = 20;
        }

        year = `${fY}` + `${s1}` + `${s2}`;
        month = `${s3}` + `${s4}`;
        day = `${s5}` + `${s6}`
        
        $('[name="year"]').val(year);
        $('[name="month"]').val(month);
        $('[name="day"]').val(day)
    });

    $("#ssnBtn").on('click', function(){
        //주민등록번호 체크
        if($('#ssn1').val() == '' || $('#ssn2').val() == '') {
            alert('주민등록번호를 입력하세요');
            return false;
        }
    
        const ssn = $('#ssn1').val() + $('#ssn2').val(); //001011 3068518
        const s1 = Number(ssn.substr(0, 1)) * 2;    //0번째부터 한글자
        const s2 = Number(ssn.substr(1, 1)) * 3;
        const s3 = Number(ssn.substr(2, 1)) * 4;
        const s4 = Number(ssn.substr(3, 1)) * 5;
        const s5 = Number(ssn.substr(4, 1)) * 6;
        const s6 = Number(ssn.substr(5, 1)) * 7;
        const s7 = Number(ssn.substr(6, 1)) * 8;
        const s8 = Number(ssn.substr(7, 1)) * 9;
        const s9 = Number(ssn.substr(8, 1)) * 2;
        const s10 = Number(ssn.substr(9, 1)) * 3;
        const s11 = Number(ssn.substr(10, 1)) * 4;
        const s12 = Number(ssn.substr(11, 1)) * 5;
        const s13 = Number(ssn.substr(12, 1));
    
        let result = s1+s2+s3+s4+s5+s6+s7+s8+s9+s10+s11+s12;
        result = result % 11;
        result = 11 - result;
        if(result >- 10) result = result % 10;
    
        if(result == s13) {
            alert('유효한 주민등록번호입니다.');
            $('#isssn').val('y');
        }else {
            alert('유효하지 않은 주민등록번호입니다.');
        }
    });

});
