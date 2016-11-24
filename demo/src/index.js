// Using the ~ syntax to refer to our `common` code folder
import randomNumbers from '~/utils/randomNumbers';
// Importing from repo-level dependency
import { uniq } from 'lodash';

const numbers = randomNumbers(20);

console.log('--- Demo:');
console.log('Original array:', numbers);
console.log('Unique array:', uniq(numbers));
