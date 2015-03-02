# marge

Fast, flexible sort using multithreaded Ruby.

### Usage

See the [spaceship operator, `<=>`](http://ruby-doc.org/core-1.9.3/Comparable.html)

```ruby
require ('marge')

unsorted = ['enumerable', 'of', 'things', 'comparable', 'with', '<=>']

unsorted_big = unsorted * 420000
maximum_time = 5000 # milliseconds

sorted = Marge.sort(unsorted)

sorted_big = Marge.sort(unsorted_big, maximum_time)
```

The sort is not in place - the input `Enumerable` is always unaffected.
If the maximum time is exceeded, the intermediate result is returned.

### License

Copyright 2015 Kirby Banman, Ryan Thornhill

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

