/**
 * 
 */
 
 var socket;

function connectWebSocket() {
    if (!socket) {
        socket = new WebSocket('ws://localhost/alarm');
        socket.onopen = function(event) {
            console.log('WebSocket 연결이 열렸습니다.');
        };

        socket.onmessage = function(event) {
            var message = event.data;
            console.log('수신된 메시지: ' + message);
            // 메시지 처리 로직 구현
        };

        socket.onclose = function(event) {
            console.log('WebSocket 연결이 닫혔습니다.');
        };

        socket.onerror = function(error) {
            console.error('WebSocket 오류:', error);
        };
    }
}

// 페이지 이동 시에는 WebSocket 연결을 유지시킴
if (!socket || socket.readyState !== WebSocket.OPEN) {
    connectWebSocket();
}