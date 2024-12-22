import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';

document.addEventListener('DOMContentLoaded', function() {
  var calendarEl = document.getElementById('calendar');

  if (calendarEl) { // カレンダーがある場合のみ実行
    var calendar = new Calendar(calendarEl, {
      plugins: [dayGridPlugin],
      initialView: 'dayGridMonth',
      locale: 'ja',
      events: '/calendars/show', // サーバーからイベントを取得するエンドポイント
      dateClick: function(info) {
        // 日付クリック時の挙動
        window.location.href = `/calendars/day_posts?date=${info.dateStr}`;
      }
    });

    calendar.render();
  }
});
