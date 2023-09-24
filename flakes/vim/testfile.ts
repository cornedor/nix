const str: string = "Foo bar baz";


function* last(input: string) {
	let i = input.length
	while (i > 0) {
		i = i - 1;
		yield input[i];
	}

	yield function end() {
		return -1;
	}

}

export function rev(input: string) {
	return [...last(input)].join("");
}

console.log(rev(str))


