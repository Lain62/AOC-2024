use std::fs;
use std::collections::HashMap;

fn parse_file_and_sort(file: String) -> Vec<Vec<i32>> {
	let mut data = Vec::new();
	let mut ldata: Vec<i32> = Vec::new();
	let mut rdata: Vec<i32> = Vec::new();
	let contents = file.split("\n");
	for content in contents {
		let split_content: Vec<_> = content.split(" ").collect();
		let split_content: Vec<_> = split_content.into_iter()
									.filter(|&x| x != "")
									.collect();
		if split_content.len() > 1 {
			ldata.push(split_content[0].parse().unwrap());
			rdata.push(split_content[1].parse().unwrap());
		}
	}
	ldata.sort();
	rdata.sort();
	data.push(ldata);
	data.push(rdata);
	assert_eq!(data[0].len(), data[1].len());
	data
}

fn first_problem(file: String) {
	let data = parse_file_and_sort(file);
	
	let mut sum = 0;
	for i in 0..data[0].len() {
		let distance = (data[0][i] - data[1][i]).abs();
		sum += distance;
	}
	// println!("{:?}", data);
	println!("{sum}");
}

fn similarity_map(data: &Vec<i32>) -> HashMap<i32, i32> {
	let mut sim_map: HashMap<i32, i32> = HashMap::new();
	
	for i in data {
		if sim_map.contains_key(&i) {
			sim_map.entry(*i).and_modify(|x| *x += 1);
		}

		if !sim_map.contains_key(&i) {
			sim_map.insert(*i, 1);
		}
		
	}
	sim_map
}

fn second_problem(file: String) {
	let data = parse_file_and_sort(file);
	
	let sim_map = similarity_map(&data[1]);

	let mut sum = 0;
	for i in &data[0] {
		if sim_map.contains_key(&i) {
			sum = sum + i * sim_map.get(i).unwrap();
		}	
	}

	println!("{sum}");
}

// fn test_file_problem(file: String) {
// 	let parts: Vec<_> = file.split("\n")
// 					.collect();
// 	println!("{:?}", parts);
// }

fn main() {
	let _test_file = fs::read_to_string("./test.txt")
						.expect("Cannot read file");
	let sample_file = fs::read_to_string("./sample.txt")
						.expect("Cannot read file");
	let input_file = fs::read_to_string("./input.txt")
						.expect("Cannot read file");
	// test_file_problem(test_file);
	
	first_problem(input_file.clone());
	second_problem(sample_file.clone());
	second_problem(input_file.clone());
}
