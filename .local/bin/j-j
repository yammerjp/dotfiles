#!/usr/bin/env node

const helpMessage = `Usage:    j-j <a JavaScript code piece to process JSON following "output = input ">

j-j is a JSON processor that can be written in a JavaScript code piece.
The command line argument code piece is interpreted as follows.

    eval("output = input " + <A CODE PIECE WITH COMMAND LINE ARGUMENT>)

The following variables are available in the code piece.

- input ... JavaScript object input as JSON from STDIN
- output ... JavaScript object output as JSON to STDOUT
- stdin ... String input from STDIN
- stdout ... String output to STDOUT (Preferred over output, if not null or undefined)

Examples of execution is shown below.

    $ echo '{"name":"bob","like":["sushi","orange"]}' | j-j '.like'
    [
     "sushi",
     "orange"
    ]

    $ echo '{"name":"bob","like":["sushi","orange"]}' | j-j '&& Object.keys(input)'
    [
     "name",
     "like"
    ]

    $ echo '{"name":"bob","like":["sushi","orange"]}' | j-j '; stdout = input.like.join("&")'
    sushi&orange

    $ echo 'hello, world' | j-j ';stdout = stdin.toUpperCase()'
    Warning: failed to parse JSON from STDIN
    HELLO, WORLD

    $ echo 'hello, world' | J_J_SILENT=true j-j ';stdout = stdin.toUpperCase()'
    HELLO, WORLD
`;

(async () => {
  if (process.stdin.isTTY) {
    console.error(helpMessage);
    return;
  }
  const buffers = [];
  for await (const chunk of process.stdin) buffers.push(chunk);
  const stdin = Buffer.concat(buffers).toString();

  let input, output, stdout;
  try {
    input = JSON.parse(stdin);
  } catch {
    // Warn when STDIN cannot be parsed to JSON, unless a suppressing environment variable is specified.
    process.env.J_J_SILENT || console.error('Warning: failed to parse JSON from STDIN');
  }
  const code = process.argv.slice(2).join(' ')
  // Evaluates the code specified in the arguments.
  eval("output = input" + code);
  console.log(stdout ?? JSON.stringify(output, null, ' '));
})();
