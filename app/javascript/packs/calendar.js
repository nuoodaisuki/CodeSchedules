import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';

document.addEventListener('DOMContentLoaded', function() {
  var calendarEl = document.getElementById('calendar');

  if (calendarEl) { // カレンダーがある場合のみ実行
    var calendar = new Calendar(calendarEl, {
      plugins: [dayGridPlugin],
      initialView: 'dayGridMonth',
      locale: 'ja',
      events: 'calendar.json', // サーバーからイベントを取得するエンドポイント
      displayEventTime: false
    });

    calendar.render();
  }
});
