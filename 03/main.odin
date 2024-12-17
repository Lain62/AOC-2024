package main

import "core:fmt"
import "core:os"
import "core:strings"
import "core:unicode"
import "core:unicode/utf8"
import "core:strconv"

first_problem :: proc(data: string) -> int {
    main := strings.builder_make()
    search := strings.builder_make()
    data_s := strings.split(data, "")
    total := 0

    parse := make([dynamic][]int)
    
    for i in 0..<len(data_s) {	
	if data_s[i] != "m" {
	    continue
	}
	strings.write_string(&search, data_s[i])
	for j in i+1..<len(data_s) {
	    
	    if strings.builder_len(search) >= 4 {
		if !strings.contains(strings.to_string(search), "mul(") {
		    strings.builder_reset(&search)		    
		    break
		}

		if data_s[j] == ")" {
		    str, _ := strings.remove(strings.to_string(search), "mul(", -1)
		    nums := strings.split(str, ",")
		    
		    
		    found := make([]int, 2)

		    for i in 0..<len(nums) {
			res, _ := strconv.parse_int(nums[i])
			found[i] = res
		    }

		    append(&parse, found)
		    
		    strings.builder_reset(&search)
		    break
		}

		_, is_num := strconv.parse_int(data_s[j])
		if !is_num && data_s[j] != "," {
		   
		    strings.builder_reset(&search)
		    break
		}
	    }	
	    strings.write_string(&search, data_s[j])
	    
	}
	
    }
    for k in 0..<len(parse) {
	num := parse[k][0] * parse[k][1]
	total = total + num
    }  
    
    return total
}

second_problem :: proc(data: string) -> int {
    main := strings.builder_make()
    search := strings.builder_make()
    search_o := true
    data_s := strings.split(data, "")
    total := 0

    parse := make([dynamic][]int)
    
    for i in 0..<len(data_s) {
	if data_s[i] != "m" && data_s[i] != "d" {
	    continue
	}

	if data_s[i] == "m" && !search_o {
	    continue
	}
	
	strings.write_string(&search, data_s[i])
	for j in i+1..<len(data_s) {	 
	    if strings.builder_len(search) >= 4 {
		if strings.contains(strings.to_string(search), "don't()") {
		    strings.builder_reset(&search)
		    search_o = false
		    break
		}
		
		if strings.contains(strings.to_string(search), "don't(") {
		    strings.write_string(&search, data_s[j])
		    continue
		}
		
		if strings.contains(strings.to_string(search), "don't") {
		    strings.write_string(&search, data_s[j])
		    continue
		}
		
		if strings.contains(strings.to_string(search), "don'") {
		    strings.write_string(&search, data_s[j])
		    continue
		}
		
		if strings.contains(strings.to_string(search), "do()") {
		    strings.builder_reset(&search)
		    search_o = true
		    break
		}
		
		if !strings.contains(strings.to_string(search), "mul(") {
		    strings.builder_reset(&search)		    
		    break
		}

		if data_s[j] == ")" {
		    str, _ := strings.remove(strings.to_string(search), "mul(", -1)
		    nums := strings.split(str, ",")		   		    
		    found := make([]int, 2)

		    for i in 0..<len(nums) {
			res, _ := strconv.parse_int(nums[i])
			found[i] = res
		    }

		    append(&parse, found)
		    
		    strings.builder_reset(&search)
		    break
		}

		_, is_num := strconv.parse_int(data_s[j])
		if !is_num && data_s[j] != "," {
		   
		    strings.builder_reset(&search)
		    break
		}
	    }	
	    strings.write_string(&search, data_s[j])
	    
	}
	
    }
    for k in 0..<len(parse) {
	num := parse[k][0] * parse[k][1]
	total = total + num
    }
    
    return total
}

main :: proc() {
    // file, _ := os.read_entire_file_from_filename("./test.txt")
    sample, _ := os.read_entire_file_from_filename("./sample.txt")
    sample2, _ := os.read_entire_file_from_filename("./sample2.txt")
    input, _ := os.read_entire_file_from_filename("./input.txt")
    data := string(input)
    sample_data := string(sample)
    sample2_data := string(sample2)

    fmt.println("sample 1 problem 1: ", first_problem(sample_data))
    fmt.println("input problem 1: ", first_problem(data))
    fmt.println("sample 2 problem 2: ", second_problem(sample2_data))
    fmt.println("input problem 2: ", second_problem(data))

    
}
