<script setup>
import { ref, computed } from 'vue'
import { useUserStore } from '@/stores'

const userStore = useUserStore()
const user = computed(() => userStore.user)

const props = defineProps({
  messages: {
    type: Array,
    required: true,
  },
  session: {
    type: Object,
    required: true,
  },
  myUserName: {
    type: String,
    required: true,
  },
  chatUserNo: {
    type: Number,
    required: false,
  },
})

const { messages, session, myUserName, chatUserNo } = props
// const userNo = ref(usewebRtcStore.userNo)
const inputMessage = ref('')

const imagePath = ref(null)

function sendMessage() {
  if (inputMessage.value.trim()) {
    // 다른 참가원에게 메시지 전송
    session.signal({
      // data: JSON.stringify({username: session.myUserName, message: inputMessage.value}), // 메시지 데이터를 문자열로 변환해서 전송
      // data: JSON.stringify({username: myUserName, message: inputMessage.value}), // 메시지 데이터를 문자열로 변환해서 전송
      // userNo는 받는 곳에서 못받음.
      // data: JSON.stringify({username: myUserName, message: inputMessage.value, userNo:userNo.value}), // 메시지 데이터를 문자열로 변환해서 전송
      // data: JSON.stringify({username: myUserName, message: inputMessage.value + '!!!' + chatUserNo}), // 메시지 데이터를 문자열로 변환해서 전송
      data: JSON.stringify({
        username: [myUserName, chatUserNo],
        message: inputMessage.value,
      }), // 메시지 데이터를 문자열로 변환해서 전송
      type: 'chat', // 신호 타입을 'chat'으로 설정
    })
    inputMessage.value = ''
  }
}
// onMounted(() => { // 필요없으면 삭제할 부분
//     setTimeout(() => {
//       // 컴포넌트가 마운트된 후에 실행되는 코드
//       if (!webrtcstore.isWelcome && (chatUserNo && myUserName)) {
//         // const joinMessage = `${myUserName} 님이 참여했습니다.\n방 규칙을 잘 지켜주세요.\n${webrtcstore.rule}`;
//         const joinMessage = `${myUserName} 님이 참여했습니다. 방 규칙을 잘 지켜주세요.`;
//         sendMessageToChat(joinMessage)
//         webrtcstore.updateisWelcome(true)              // 참여 메세지를 보냈음을 보여줌
//       }
//     }, 400)
//   })
//   // onBeforeUnmount(() => {  // 오작동함.
//   //   // 컴포넌트가 마운트된 후에 실행되는 코드
//   //   // if (chatUserNo && myUserName) {
//   //   //   const exitmessage = `${myUserName} 님이 퇴장했습니다.`;
//   //   //   sendMessageToChat(exitmessage)
//   //   // }
//   //   const exitmessage = `${myUserName} 님이 퇴장했습니다.`;
//   //   sendMessageToChat(exitmessage)
//   // })
</script>

<template>
  <div id="chatContainer">
    <div id="chatWindow">
      <ul id="chat-history">
        <div id="chat-welcome">
          <div>환영합니다!</div>
          <div>
            {{ user.username }}
            <div id="random-profile-image"></div>
          </div>
        </div>
        <li
          v-for="(message, index) in messages"
          :key="index">
          <div
            v-if="message.username[0] == '나'"
            class="message-mine">
            {{ message.message }}
          </div>
          <div
            v-else
            class="message-others">
            <div>{{ message.username[0] }}</div>
            {{ message.message }}
          </div>
        </li>
      </ul>
    </div>
    <form id="chat-write">
      <input
        id="message-text-area"
        type="text"
        placeholder="전달할 내용을 입력하세요."
        v-model="inputMessage" />
      <button
        id="message-text-btn"
        @click.prevent="sendMessage">
        전송
      </button>
    </form>
  </div>
</template>

<style>
#chat-history {
  height: calc(100vh - 360px);
  min-height: 240px;

  list-style: none;
  padding: 10px;

  overflow-x: hidden;
  overflow-y: scroll;
}

#chat-history::-webkit-scrollbar {
  width: 5px;
}

#chat-history::-webkit-scrollbar-thumb {
  background: #a0a0a0; /* 스크롤바 색상 */
  border-radius: 3px;
}

#chat-history::-webkit-scrollbar-track {
  background: rgba(255, 255, 255, 0); /*스크롤바 뒷 배경 색상*/
}

#chat-history::-webkit-scrollbar-button {
  height: 6px;
}

#chat-welcome {
  width: 260px;
  height: 100px;

  border-left: 5px solid var(--font30);

  display: table-cell;
  vertical-align: middle;
}

#chat-welcome > div:first-child {
  font-size: 1.4rem;
  font-family: 'ASDGothicM';
  margin-left: 10px;
}

#chat-welcome > div:nth-child(2) {
  font-size: 1.4rem;
  font-family: 'ASDGothicH';
  margin-left: 10px;
}

#random-profile-image {
  position: relative;
  top: 9px;

  display: inline-block;
  width: 4rem;
  height: 2rem;

  background-size: cover;
  background-position: center;

  border-radius: 1rem;
}

#chat-history > li {
  position: relative;
  display: block;
  width: 260px;
  min-height: 40px;
}

#chat-history > li > div {
  padding: 6px 10px 6px 10px;
  display: inline-block;

  max-width: 210px;
  word-break: break-all;
}

#chat-history > li > .message-mine {
  position: relative;
  float: right;
  clear: both;
  margin-top: 10px;

  color: #f8f8f2;
  font-family: 'ASDGothicUL';

  background-color: var(--hl-pres);

  border-radius: 1.1rem 0px 1.1rem 1.1rem;
}

#chat-history > li > .message-others {
  position: relative;
  margin-top: 25px;
  background-color: #e5e5e5;

  color: #000000;
  border-radius: 0px 1.1rem 1.1rem 1.1rem;
}

.message-others > div {
  position: absolute;
  top: -1.1rem;
  left: 0px;

  font-size: 0.8rem;
  color: var(--font100);

  white-space: nowrap;
}

#chat-write {
  position: relative;
}

#message-text-area {
  width: 194px;
  height: 30px;

  margin-left: 9px;
  margin-bottom: 9px;

  border: 1px solid var(--font30);
  border-radius: 20px;
  padding: 3px;
  padding-left: 10px;
  padding-right: 55px;
}

#message-text-btn {
  position: absolute;
  top: 7px;
  right: 17px;

  width: 28;
  height: 28;

  padding: 2px 8px 4px 8px;

  color: #ffffff;

  border: 0px;
  border-radius: 15px;

  background-color: #202020;

  cursor: pointer;
}
</style>
