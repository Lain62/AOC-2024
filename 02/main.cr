enum CheckState
	NONE
	DESCENDING
	ASCENDING
end


def is_report_safe?(rep)
	i = 0
	check_st = CheckState::NONE
	while i < rep.size() - 1
		if rep[i] == rep[i + 1]
			return false
		end

		if (rep[i] - rep[i + 1]).abs() > 3
			return false
		end

		case check_st
		when CheckState::NONE
			if rep[i] < rep[i + 1]
				check_st = CheckState::ASCENDING
			end

			if rep[i] > rep[i + 1]
				check_st = CheckState::DESCENDING
			end

		when CheckState::ASCENDING
			if rep[i] > rep[i + 1]
				return false
			end

		when CheckState::DESCENDING
			if rep[i] < rep[i + 1]
				return false
			end
		end
		
		i += 1
	end

	return true
end

def check_with_tolerance(rep)
	i = 0
	while i < rep.size()
		new_rep = rep.clone()
		new_rep.delete_at(i)
		if is_report_safe?(new_rep)
			return true
		end
		i += 1
	end
	return false
end

def second_problem(ctn)
	ctn = ctn.chomp().split("\n")
	
	ctn = ctn.map do |x|
		x.split(" ").map() {|i| i.to_i}
	end

	safe_count = 0
	ctn.each do |rep|
		if is_report_safe?(rep)
			safe_count += 1
		elsif check_with_tolerance(rep)
			safe_count += 1
		end
	end 
	
	return safe_count
end

def first_problem(ctn)
	ctn = ctn.chomp().split("\n")
	
	ctn = ctn.map do |x|
		x.split(" ").map() {|i| i.to_i}
	end

	safe_count = 0
	ctn.each do |rep|
		if is_report_safe?(rep)
			safe_count += 1
		end
	end 
	
	return safe_count
end

def main(args)
	args.each do |arg|
		ctn = File.read(arg)
		p "First Algo #{arg} #{first_problem(ctn)}"
		p "Second Algo #{arg} #{second_problem(ctn)}"
	end
end

main(ARGV)
