#!/usr/bin/env node

const readline = require('readline/promises');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

const apiEndpoint = 'https://api.openai.com/v1/chat/completions'

const messages = [];

const getOpenAIResponse = async () => {
  try {
    const response = await fetch(apiEndpoint, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${process.env.OPENAI_API_KEY}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        model: "gpt-4-1106-preview",
        messages
      })
    });
    const data = await response.json();
    messages.push(data.choices[0].message)
  } catch (error) {
    console.error('Error calling OpenAI API:', error);
    return '';
  }
};

(async () => {
  while(1) {
  let content = ""
  
  content = await rl.question('You: ')
  if (content.toLowerCase() === 'quit') {
    rl.close();
    return;
  }
  messages.push({ role: "user", content })
  await getOpenAIResponse(messages);
  console.log('AI:', messages.at(-1).content);

  }
})()
