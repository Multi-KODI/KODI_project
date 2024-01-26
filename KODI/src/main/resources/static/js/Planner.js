const daysTag = document.querySelector(".days"),
  currentDate = document.querySelector(".current-date"),
  prevNextIcon = document.querySelectorAll(".icons span");

let date = new Date(),
  currYear = date.getFullYear(),
  currMonth = date.getMonth();

let selectedDates = [];

const months = ["1월", "2월", "3월", "4월", "5월", "6월", "7월",
  "8월", "9월", "10월", "11월", "12월"];

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
  currentDate.innerText = `${currYear}년 ${months[currMonth]}`;
  daysTag.innerHTML = liTag;

  // 각 날짜에 클릭 이벤트 리스너 추가
  document.querySelectorAll('.days li').forEach(day => {
    day.addEventListener('click', () => {
      const clickedDate = day.getAttribute('data-date');
      handleDateSelection(clickedDate);
    });
  });
}

const modal = document.querySelector(".modal");
let map = null //controller에서 받아오기

const handleDateSelection = (clickedDate) => {
  // 두 날짜가 이미 선택되어 있다면 선택을 초기화합니다.
  if (selectedDates.length === 2) {
    selectedDates = [];
  }

  // 클릭한 날짜를 선택 목록에 추가합니다.
  selectedDates.push(clickedDate);

  // 선택된 날짜를 콘솔에 표시합니다.
  console.log('선택된 날짜:', selectedDates);

  // 두 날짜가 선택된 경우, 선택된 날짜 사이의 모든 날짜를 콘솔에 표시합니다.
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
     	 makeModal(dateRange, schedulelist);
      },
      error:function(error){
         console.log(error);
      }
      
      
   });
    console.log('선택된 날짜 사이의 모든 날짜:', dateRange);
    
    
  }
}

function makeModal(dateList, schedulelist){
   document.querySelector('.modal').style.display ='block';
   var container = document.querySelector('.modal');
deleteAllChildren(container);
   
   for (var i = 0; i < dateList.length; i++) {
     var modalDiv = document.createElement('div');
     modalDiv.className = 'modalDate' + i;
     modalDiv.innerHTML = dateList[i];
    dateList[i] = "\'" + dateList[i] + "\'"; 
    modalDiv.innerHTML += 
    '<button class="modalBtn" id="insertBtn' + i + '" onclick="saveDiv(' + dateList[i] + ' , ' + i +')">저장</button>'
    + '<button class="modalBtn" id="deleteBtn' + i + '\" onclick=\"deleteDiv(' + i + ')\">삭제</button>'+'<input type=\'text\' value=\''+schedulelist[i]+'\'></input><br>';
     document.querySelector('.modal').appendChild(modalDiv);
   }
   
}

function deleteAllChildren(element) {
    // element의 모든 자식을 삭제
    while (element.firstChild) {
        element.removeChild(element.firstChild);
    }
}

function deleteDiv(index) {
    var container = document.querySelector('.modal');
    
    // 지정된 div 내의 input 요소 가져오기
    var inputElement = container.children[index].querySelector('input');
    
    // input 요소의 값을 빈 문자열로 설정
    inputElement.value = "";
}

function saveDiv(target, index) {
    var container = document.querySelector('.modal');
    
    // 지정된 div 내의 input 요소 가져오기
    var inputElement = container.children[index].querySelector('input');
    
    // input 요소의 값을 빈 문자열로 설정
    var date = target;
    var content=inputElement.value;
    $.ajax({
      url:"/api/planner/schedule/issave",
      type:'post',
      data:{ 
         date:date,
         content:content
      },
      success : function(result) { 
          
         },    
      error : function(error) {  
            console.log(error);
         }
      
   });
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