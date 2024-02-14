										/*플래너 구현*/
let newlanguage = language.value;
										
const daysTag = document.querySelector(".days"),
  currentDate = document.querySelector(".current-date"),
  prevNextIcon = document.querySelectorAll(".icons span");

let date = new Date(),
  currYear = date.getFullYear(),
  currMonth = date.getMonth();

let selectedDates = [];

const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul",
  "Aug", "Sep", "Oct", "Nov", "Dec"];

const renderCalendar = () => {
  	let firstDayofMonth = new Date(currYear, currMonth, 1).getDay(),
    lastDateofMonth = new Date(currYear, currMonth + 1, 0).getDate(),
    lastDayofMonth = new Date(currYear, currMonth, lastDateofMonth).getDay(),
    lastDateofLastMonth = new Date(currYear, currMonth, 0).getDate();
  	let liTag = "";

  for (let i = firstDayofMonth; i > 0; i--) {
    liTag += `<li class="inactive">${lastDateofLastMonth - i + 1}</li>`;
  }

  for (let i = 1; i <= lastDateofMonth; i++) {
    let isToday = i === date.getDate() && currMonth === new Date().getMonth() &&
      currYear === new Date().getFullYear() ? "active" : "";
    liTag += `<li class="${isToday}" data-date="${currYear}-${currMonth + 1}-${i}">${i}</li>`;
  }

  for (let i = lastDayofMonth; i < 6; i++) {
    liTag += `<li class="inactive">${i - lastDayofMonth + 1}</li>`;
  }
  currentDate.innerText = `${currYear} ${months[currMonth]}`;
  daysTag.innerHTML = liTag;
  
  
  /*수정 선택된 날짜에 배경색*/
  document.querySelectorAll('.days li').forEach(day => {
  day.addEventListener('click', () => {
    const clickedDate = day.getAttribute('data-date');
    handleDateSelection(clickedDate);

    // 클릭된 날짜에 대한 스타일 처리
    document.querySelectorAll('.days li').forEach(dayElement => {
      dayElement.classList.remove('selected');
    });

    day.classList.add('selected');
  });
});

  /*// 각 날짜에 클릭 이벤트 리스너 추가
  document.querySelectorAll('.days li').forEach(day => {
    day.addEventListener('click', () => {
      const clickedDate = day.getAttribute('data-date');
      handleDateSelection(clickedDate);
    });
  });*/
}

const modal = document.querySelector(".modal");
let map = null //controller에서 받아오기

const handleDateSelection = (clickedDate) => {
  // 두 날짜가 이미 선택되어 있다면 선택을 초기화
  if (selectedDates.length === 2 || 
      (selectedDates.length === 1 && clickedDate < selectedDates[0])) {
    selectedDates = [];
    document.querySelectorAll('.days li.selected').forEach(dayElement => {
      dayElement.classList.remove('selected');
    });
}
  // 클릭한 날짜를 선택 목록에 추가
  selectedDates.push(clickedDate);

  // 선택된 날짜를 콘솔에 표시
  console.log('선택된 날짜:', selectedDates);

  // 두 날짜가 선택된 경우, 선택된 날짜 사이의 모든 날짜를 콘솔에 표시
  if (selectedDates.length === 2) {
    const startDate = new Date(selectedDates[0]);
    const endDate = new Date(selectedDates[1]);
    startDate.setDate(startDate.getDate()+1);
    endDate.setDate(endDate.getDate()+1);
    const dateRange = getDateRange(startDate, endDate);
    
    $.ajax({
      url:"/api/planner/schedule",
      type:"post",
      data:{
         day1:dateRange[0],
         day2:dateRange[dateRange.length-1]   
      },
      
      success:function(response){
         console.log(response)
         var schedulelist = response.schedulelist;
     	 makeModal(dateRange, schedulelist, newlanguage);
      },
      error:function(error){
         console.log(error);
      }
      
      
   });
    console.log('선택된 날짜 사이의 모든 날짜:', dateRange); 
  }
    if (selectedDates.length === 2 && clickedDate < selectedDates[0]) {
    document.querySelectorAll('.days li.selected').forEach(dayElement => {
      dayElement.classList.remove('selected');
    });
    selectedDates = [];
  }
  
}

function makeModal(dateList, schedulelist, newlanguage){
   	document.querySelector('.modal').style.display ='block';
   	var container = document.querySelector('.pop-planner');
   	/*var container = document.querySelector('.pop-modal');*/
	removeOneScheduleElements(container);
	for (var i = 0; i < dateList.length; i++) {
		var modalDiv = document.createElement('div');
		modalDiv.className = 'oneSchedule';
		modalDiv.innerHTML += dateList[i];
		dateList[i] = "\'" + dateList[i] + "\'"; 
		if(schedulelist[i]==null){
			schedulelist[i]='';
		}
		
		if(newlanguage == "en") {
			modalDiv.innerHTML +=
			'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button class="modalBtn" id="insertBtn" onclick="saveDiv(' + dateList[i] + ',' + i + ',' + newlanguage + ')">Save</button>&nbsp;'
			+'<button class="modalBtn" id="deleteBtn" onclick="deleteDiv(' + i+','+dateList[i] + ',' + newlanguage+')">Del</button><br>'
			+'<textarea class="scheduleContent" cols="25" rows="7">'+schedulelist[i]+'</textarea><br>';
		}
		else {
			modalDiv.innerHTML +=
			'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button class="modalBtn" id="insertBtn" onclick="saveDiv(' + dateList[i] + ',' + i + ',' + newlanguage + ')">저장</button>&nbsp;'
			+'<button class="modalBtn" id="deleteBtn" onclick="deleteDiv(' + i+','+dateList[i] + ',' + newlanguage+')">삭제</button><br>'
			+'<textarea class="scheduleContent" cols="25" rows="7">'+schedulelist[i]+'</textarea><br>';
		}

		document.querySelector('.pop-planner').appendChild(modalDiv);
   } 
}
function removeOneScheduleElements(container) {
    var oneScheduleElements = container.getElementsByClassName('oneSchedule');
    if (oneScheduleElements.length > 0) {
        while (oneScheduleElements.length > 0) {
            oneScheduleElements[0].parentNode.removeChild(oneScheduleElements[0]);
        }
    }
}


function deleteAllChildren(element) {
    // element의 모든 자식을 삭제
    while (element.firstChild) {
        element.removeChild(element.firstChild);
    }
}

function deleteDiv(index, date, newlanguage) {
    var container = document.querySelector('.pop-planner');
    console.log(container.tagName);
    console.log(container.children.length +":" + index);
    console.log(container.children[index]);
    // 지정된 div 내의 input 요소 가져오기
    var inputElement = container.children[index].querySelector('textarea');
    inputElement.value="";
    console.log(inputElement);
    
    if(newlanguage.value == "ko") {
	    if(confirm("해당 일정을 삭제하시겠습니까?")) {
		    $.ajax({
			  	url:"/api/planner/schedule/isdelete",
			  	type:'post',
			  	data:{ 
			     	date:date,
			 	},
			 	success: function(){
					 
				 },
				error : function(error) {  
		        	console.log(error);
				}
		      
		   });
		}
	}
	else {
		if(confirm("Are you sure you want to delete this schedule?")) {
		    $.ajax({
			  	url:"/api/planner/schedule/isdelete",
			  	type:'post',
			  	data:{ 
			     	date:date,
			 	},
			 	success: function(){
					 
				 },
				error : function(error) {  
		        	console.log(error);
				}
		      
		   });
		}
	}
    
}

function saveDiv(target, index, newlanguage) {
    /*var container = document.querySelector('.pop-modal');*/
	var container = document.querySelector('.pop-planner');
    
 var inputElement = container.children[index].querySelector('textarea');
 

 /*   // 지정된 div 내의 input 요소 가져오기
   var inputElement = container.children[index].querySelector('input');
    alert(container.children[index].querySelector('input').value);
    alert(inputElement.value);*/
    
    
    // input 요소의 값을 빈 문자열로 설정
    var date = target;
    console.log(inputElement);
  	var content=inputElement.value;
    $.ajax({
	  	url:"/api/planner/schedule/issave",
	  	type:'post',
	  	data:{ 
	     	date:date,
	     	content:content
	 	},
	 	success: function(){
			 
		 }, 
		error : function(error) {  
        	console.log(error);
		}
      
   });
   if(newlanguage.value == "ko") {
	   alert("저장되었습니다");
   }
   else {
	   alert("Schedule has been saved.");
   }
}

const getDateRange = (start, end) => {
  const dateRange = [];
  let currentDate = new Date(start);
  
  while (currentDate <= end) {
    dateRange.push(new Date(currentDate).toISOString().split('T')[0]);
    currentDate.setDate(currentDate.getDate() + 1);
  }

  return dateRange;
}


renderCalendar();

prevNextIcon.forEach(icon => {
  icon.addEventListener("click", () => {
    currMonth = icon.id === "prev" ? currMonth - 1 : currMonth + 1;

    if (currMonth < 0 || currMonth > 11) {
      date = new Date(currYear, currMonth, new Date().getDate());
      currYear = date.getFullYear();
      currMonth = date.getMonth();
    } else {
      date = new Date();
    }
    renderCalendar();
  });
});

function closePlannerModal(){
	$(".modal").hide();
	
	document.querySelectorAll('.days li').forEach(dayElement => {
    dayElement.classList.remove('selected');
  });
}


											/*체크리스트 구현*/
loadCheckList();

function loadCheckList(){
	$.ajax({
                type: "get",
                url: "/api/plannerstart",
                success: function(response) {
			
                	makeCheckList(response[0], response[1]);
                },
                error: function(status, error) {
                    console.error("AJAX request failed:", status, error);
                }
            });
}
function makeCheckList(checkList, idxList) {
    var checkListContainer = document.querySelector('.checkList');
    checkListContainer.innerHTML = "";

    for (var i = 0; i < idxList.length; i++) {
        var listItemContainer = document.createElement('div'); // 각 쌍을 감싸는 div
        listItemContainer.style.display = "block"; // 인라인 블록으로 배치

        var oneLi = document.createElement('li');
        oneLi.className = "'"+idxList[i]+"'";
        oneLi.innerHTML = checkList[i];
        oneLi.style.display = "inline-block"; // 인라인 블록으로 배치
        oneLi.style.marginRight = "100px"; // 필요에 따라 마진 조절
        listItemContainer.appendChild(oneLi);

        var oneLiDelete = document.createElement('img');
        oneLiDelete.className = "'"+idxList[i]+"'";
        oneLiDelete.src = '/image/icon/x.png';
        oneLiDelete.width = 10;
        oneLiDelete.height = 10;
        oneLiDelete.style.cursor = "pointer";
        oneLiDelete.style.verticalAlign = "middle"; // 이미지를 수직 가운데 정렬
        listItemContainer.appendChild(oneLiDelete);
	

        checkListContainer.appendChild(listItemContainer);

       
        oneLiDelete.setAttribute('onclick', 'deleteLi(' + idxList[i] + ')');
    }
}

function deleteLi(idx) {
    var targetClassName = "'" + idx + "'";
    var container = document.querySelector('.checkList');
    var listItemContainers = container.getElementsByTagName('div');

    for (var i = listItemContainers.length - 1; i >= 0; i--) {
        var currentContainer = listItemContainers[i];
        var currentLi = currentContainer.getElementsByTagName('li')[0];
        var currentImg = currentContainer.getElementsByTagName('img')[0];

        // 특정 클래스를 가진 <li> 요소인지 확인
        if (currentLi.className === targetClassName) {
            currentContainer.remove();
        }
    }

    // 나머지 코드는 그대로 둡니다.
    $.ajax({
        url: "/api/planner/checklist/isdelete",
        data: {
            listIdx: idx
        },
        type: "post",
        success: function () {},
        error: function (e) {
            console.log(e);
        },
    });
}




function makeCheckListModal(){
	$("#modal").show();
}

function closeCheckListModal(){
	$("#modal").hide();
}

function addLi(){
	var content = $("#inputCheckList").val();
	$.ajax({
		url:"/api/planner/checklist/issave",
		data: {
			content:content
			},
		type:'post',
		success: function(){},
		error: function(){}
	});
	
	location.href="/api/planner";
	
}
