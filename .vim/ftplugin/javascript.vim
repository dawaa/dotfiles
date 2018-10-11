nmap <buffer> <leader>dc :.s/import\s\(\({\s\?\(\w\+\)\s\?}\)\\|\(\w\+\)\)\sfrom/\=submatch(3) == '' ? 'import { '.submatch(1).' } from' : 'import '.submatch(3).' from'/g<cr>
