use primes::PrimeSet;

const BASE: u64 = 10;
const NUM_NUMBERS: usize = 5;

#[derive(Clone, Copy, Debug)]
struct Number {
    value: u64,
    num_digits: u64,
}

fn main() {
    let factors = find_numbers();
    let answer: u64 = factors.iter().sum();
    println!("{}", answer);
}

fn find_numbers() -> Vec<u64> {
    let mut groups: Vec<Vec<Number>> = Vec::new();
    let mut pset = PrimeSet::new();
    for prime in pset.iter() {
        let num = Number::new(prime);
        if let Some(answer) = insert_into_groups(num, &mut groups) {
            return extract_answer(&answer);
        }
    }
    vec![]
}

fn extract_answer(numbers: &[Number]) -> Vec<u64> {
    numbers.iter().map(|num| num.value).collect()
}

fn insert_into_groups(
    num: Number,
    groups: &mut Vec<Vec<Number>>,
) -> Option<Vec<Number>> {
    let mut new_groups = vec![vec![num]];
    for group in groups.iter() {
        if group.iter().all(|num2| do_match(num, *num2)) {
            new_groups.push(group.iter().cloned().chain(Some(num)).collect());
        }
    }
    groups.extend_from_slice(&new_groups);
    new_groups
        .iter()
        .find(|group| group.len() >= NUM_NUMBERS)
        .cloned()
}

fn do_match(num1: Number, num2: Number) -> bool {
    let concatenated1 = num1.concatenate(&num2);
    if !primes::is_prime(concatenated1) {
        return false;
    }
    let concatenated2 = num2.concatenate(&num1);
    if !primes::is_prime(concatenated2) {
        return false;
    }
    true
}

impl Number {
    pub fn new(value: u64) -> Self {
        let num_digits = Number::count_digits(value);
        Number { value, num_digits }
    }

    pub fn concatenate(&self, other: &Number) -> u64 {
        let shifted_self = self.value * BASE.pow(other.num_digits as u32);
        shifted_self + other.value
    }

    fn count_digits(mut value: u64) -> u64 {
        if value == 0 {
            return 1;
        }
        let mut num_digits = 0;
        while value > 0 {
            num_digits += 1;
            value /= BASE;
        }
        num_digits
    }
}
