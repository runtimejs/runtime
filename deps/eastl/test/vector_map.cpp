#include <string>

#include "test.hpp"

#include <cassert>
#include <iostream>

#include <EASTL/string.h>
#include <EASTL/vector_map.h>


using eastl::string;


bool fncomp (char lhs, char rhs) {return lhs<rhs;}

struct classcomp {
  bool operator() (const char& lhs, const char& rhs) const
  {return lhs<rhs;}
};

static void constructor() {
  eastl::vector_map<char, int> first;

  first['a']=10;
  first['b']=30;
  first['c']=50;
  first['d']=70;

  eastl::vector_map<char, int> second(first.begin(),first.end());

  eastl::vector_map<char, int> third (second);

  eastl::vector_map<char,int, classcomp> fourth;                 // class as Compare

  bool(*fn_pt)(char,char) = fncomp;
  eastl::vector_map<char,int,bool(*)(char, char)> fifth (fn_pt); // function pointer as Compare
}

static void assign_operator() {
  eastl::vector_map<char, int> first;
  eastl::vector_map<char, int> second;

  first['x']=8;
  first['y']=16;
  first['z']=32;

  second=first;           // second now contains 3 ints
  first=eastl::vector_map<char, int>();  // and first is now empty

  assert(first.size() == 0);
  assert(second.size() == 3);
}

static void begin_end() {
  eastl::vector_map<char, int> mymap;

  mymap['b'] = 100;
  mymap['a'] = 200;
  mymap['c'] = 300;

  eastl::pair<char, int> const results[] = {
    eastl::make_pair('a', 200),
    eastl::make_pair('b', 100),
    eastl::make_pair('c', 300),
  };
  // show content:
  for (eastl::vector_map<char, int>::iterator it=mymap.begin(); it != mymap.end(); ++it ) {
    assert(results[eastl::distance(mymap.begin(), it)].first == it->first);
    assert(results[eastl::distance(mymap.begin(), it)].second == it->second);
  }
}

static void rbegin_rend() {
  eastl::vector_map<char, int> mymap;
  eastl::vector_map<char, int>::reverse_iterator rit;

  mymap['x'] = 100;
  mymap['y'] = 200;
  mymap['z'] = 300;

  eastl::pair<char, int> const results[] = {
    eastl::make_pair('z', 300),
    eastl::make_pair('y', 200),
    eastl::make_pair('x', 100),
  };
  // show content:
  for ( rit=mymap.rbegin() ; rit != mymap.rend(); rit++ ) {
    assert(results[eastl::distance(mymap.rbegin(), rit)].first == rit->first);
    assert(results[eastl::distance(mymap.rbegin(), rit)].second == rit->second);
  }
}

static void empty() {
  eastl::vector_map<char, int> mymap;

  mymap['a']=10;
  mymap['b']=20;
  mymap['c']=30;

  eastl::pair<char, int> const results[] = {
    eastl::make_pair('a', 10),
    eastl::make_pair('b', 20),
    eastl::make_pair('c', 30),
  };

  eastl::pair<char, int> const* result_pos = results;

  while (!mymap.empty())
  {
    assert(mymap.begin()->first == result_pos->first);
    assert(mymap.begin()->second == result_pos->second);
    mymap.erase(mymap.begin());
    ++result_pos;
  }
}

static void size() {
  eastl::vector_map<char, int> mymap;
  mymap['a']=101;
  mymap['b']=202;
  mymap['c']=302;

  assert(mymap.size() == 3);
}

static void max_size() {
  int i;
  eastl::vector_map<int, int> mymap;

  if (mymap.max_size()>1000)
  {
    for (i=0; i<1000; i++) mymap[i]=0;
    assert(mymap.size() == 1000);
  }
}

static void index_operator() {
  eastl::vector_map<char, string> mymap;

  mymap['a']="an element";
  mymap['b']="another element";
  mymap['c'] = string(mymap['b']);

  assert(mymap['a'] == "an element");
  assert(mymap['b'] == "another element");
  assert(mymap['c'] == "another element");
  assert(mymap['d'] == "");

  assert(mymap.size() == 4);
}

static void insert() {
  eastl::vector_map<char, int> mymap;
  eastl::vector_map<char, int>::iterator it;
  eastl::pair<eastl::vector_map<char,int>::iterator, bool> ret;

  // first insert function version (single parameter):
  mymap.insert ( eastl::pair<char,int>('a',100) );
  mymap.insert ( eastl::pair<char,int>('z',200) );
  assert(mymap['z'] == 200);

  ret=mymap.insert (eastl::pair<char,int>('z',500) );
  if (ret.second==false)
  {
    assert(ret.second == false);
    assert(ret.first->first == 'z');
    assert(ret.first->second == 200);
  }

  // second insert function version (with hint position):
  it=mymap.begin();
  mymap.insert (it, eastl::pair<char,int>('b',300));  // max efficiency inserting
  mymap.insert (it, eastl::pair<char,int>('c',400));  // no max efficiency inserting

  // third insert function version (range insertion):
  eastl::vector_map<char, int> anothermap;
  anothermap.insert(mymap.begin(),mymap.find('c'));

  eastl::pair<char, int> const result[] = {
    eastl::make_pair('a', 100),
    eastl::make_pair('b', 300),
    eastl::make_pair('c', 400),
    eastl::make_pair('z', 200),
  };

  // showing contents:
  for ( it=mymap.begin() ; it != mymap.end(); ++it ) {
    assert(it->first == result[eastl::distance(mymap.begin(), it)].first);
    assert(it->second == result[eastl::distance(mymap.begin(), it)].second);
  }

  for ( it=anothermap.begin() ; it != anothermap.end(); ++it ) {
    assert(it->first == result[eastl::distance(anothermap.begin(), it)].first);
    assert(it->second == result[eastl::distance(anothermap.begin(), it)].second);
  }
}

static void erase() {
  eastl::vector_map<char, int> mymap;
  eastl::vector_map<char, int>::iterator it;

  // insert some values:
  mymap['a']=10;
  mymap['b']=20;
  mymap['c']=30;
  mymap['d']=40;
  mymap['e']=50;
  mymap['f']=60;

  it=mymap.find('b');
  mymap.erase (it);                   // erasing by iterator

  mymap.erase ('c');                  // erasing by key

  it=mymap.find ('e');
  mymap.erase ( it, mymap.end() );    // erasing by range

  eastl::pair<char, int> const result[] = {
    eastl::make_pair('a', 10),
    // eastl::make_pair('b', 20),
    // eastl::make_pair('c', 30),
    eastl::make_pair('d', 40),
    // eastl::make_pair('e', 50),
    // eastl::make_pair('f', 60),
  };

  // show content:
  for ( it=mymap.begin() ; it != mymap.end(); it++ ) {
    assert(it->first == result[eastl::distance(mymap.begin(), it)].first);
    assert(it->second == result[eastl::distance(mymap.begin(), it)].second);
  }
}

static void swap() {
  eastl::vector_map<char, int> foo;
  eastl::vector_map<char, int> bar;
  eastl::vector_map<char, int>::iterator it;

  foo['x']=100;
  foo['y']=200;

  bar['a']=11;
  bar['b']=22;
  bar['c']=33;

  foo.swap(bar);

  assert(foo.size() == 3);
  assert(bar.size() == 2);

  eastl::pair<char, int> const foo_result[] = {
    eastl::make_pair('a', 11),
    eastl::make_pair('b', 22),
    eastl::make_pair('c', 33),
  };
  eastl::pair<char, int> const bar_result[] = {
    eastl::make_pair('x', 100),
    eastl::make_pair('y', 200),
  };

  for ( it=foo.begin() ; it != foo.end(); it++ ) {
    assert(it->first == foo_result[eastl::distance(foo.begin(), it)].first);
    assert(it->second == foo_result[eastl::distance(foo.begin(), it)].second);
  }

  for ( it=bar.begin() ; it != bar.end(); it++ ) {
    assert(it->first == bar_result[eastl::distance(bar.begin(), it)].first);
    assert(it->second == bar_result[eastl::distance(bar.begin(), it)].second);
  }
}

static void clear() {
  eastl::vector_map<char, int> mymap;
  eastl::vector_map<char, int>::iterator it;

  eastl::pair<char, int> const before_result[] = {
    eastl::make_pair('x', 100),
    eastl::make_pair('y', 200),
    eastl::make_pair('z', 300),
  };

  mymap['x']=100;
  mymap['y']=200;
  mymap['z']=300;

  for ( it=mymap.begin() ; it != mymap.end(); it++ ) {
    assert(it->first == before_result[eastl::distance(mymap.begin(), it)].first);
    assert(it->second == before_result[eastl::distance(mymap.begin(), it)].second);
  }

  eastl::pair<char, int> const after_result[] = {
    eastl::make_pair('a', 1101),
    eastl::make_pair('b', 2202),
  };

  mymap.clear();
  mymap['a']=1101;
  mymap['b']=2202;

  for ( it=mymap.begin() ; it != mymap.end(); it++ ) {
    assert(it->first == after_result[eastl::distance(mymap.begin(), it)].first);
    assert(it->second == after_result[eastl::distance(mymap.begin(), it)].second);
  }
}

static void key_comp() {
  eastl::vector_map<char, int> mymap;
  eastl::vector_map<char, int>::key_compare mycomp;
  eastl::vector_map<char, int>::iterator it;
  char highest;

  mycomp = mymap.key_comp();

  mymap['a']=100;
  mymap['b']=200;
  mymap['c']=300;

  highest=mymap.rbegin()->first;     // key value of last element

  assert(highest == 'c');

  eastl::pair<char, int> const result[] = {
    eastl::make_pair('a', 100),
    eastl::make_pair('b', 200),
    eastl::make_pair('c', 300),
  };

  it=mymap.begin();
  do {
    assert(it->first == result[eastl::distance(mymap.begin(), it)].first);
    assert(it->second == result[eastl::distance(mymap.begin(), it)].second);
  } while ( mycomp((*it++).first, highest) );
}

static void value_comp() {
  eastl::vector_map<char, int> mymap;
  eastl::vector_map<char, int>::iterator it;
  eastl::pair<char,int> highest;

  mymap['x']=1001;
  mymap['y']=2002;
  mymap['z']=3003;

  highest=*mymap.rbegin();          // last element

  eastl::pair<char, int> const result[] = {
    eastl::make_pair('x', 1001),
    eastl::make_pair('y', 2002),
    eastl::make_pair('z', 3003),
  };

  it=mymap.begin();
  do {
    assert(it->first == result[eastl::distance(mymap.begin(), it)].first);
    assert(it->second == result[eastl::distance(mymap.begin(), it)].second);
  } while ( mymap.value_comp()(*it++, highest) );
}

static void find() {
  eastl::vector_map<char, int> mymap;
  eastl::vector_map<char, int>::iterator it;

  mymap['a']=50;
  mymap['b']=100;
  mymap['c']=150;
  mymap['d']=200;

  it=mymap.find('b');
  mymap.erase (it);
  mymap.erase (mymap.find('d'));

  // print content:
  assert(mymap.find('a')->second ==  50);
  assert(mymap.find('c')->second == 150);
}

static void count() {
  eastl::vector_map<char, int> mymap;
  char c;

  mymap ['a']=101;
  mymap ['c']=202;
  mymap ['f']=303;

  int result = 0;
  for (c='a'; c<'h'; c++) { result += mymap.count(c); }
  assert(result == 3);
}

static void upper_lower_bound() {
  eastl::vector_map<char, int> mymap;
  eastl::vector_map<char, int>::iterator it,itlow,itup;

  mymap['a']=20;
  mymap['b']=40;
  mymap['c']=60;
  mymap['d']=80;
  mymap['e']=100;

  itlow=mymap.lower_bound ('b');  // itlow points to b
  itup=mymap.upper_bound ('d');   // itup points to e (not d!)

  mymap.erase(itlow,itup);        // erases [itlow,itup)

  eastl::pair<char, int> const result[] = {
    eastl::make_pair('a', 20),
    // eastl::make_pair('b', 40),
    // eastl::make_pair('c', 60),
    // eastl::make_pair('d', 80),
    eastl::make_pair('e', 100),
  };

  // print content:
  for ( it=mymap.begin() ; it != mymap.end(); it++ ) {
    assert(it->first == result[eastl::distance(mymap.begin(), it)].first);
    assert(it->second == result[eastl::distance(mymap.begin(), it)].second);
  }
}

static void equal_range() {
  eastl::vector_map<char, int> mymap;
  eastl::pair<eastl::vector_map<char, int>::iterator,
      eastl::vector_map<char, int>::iterator> ret;

  mymap['a']=10;
  mymap['b']=20;
  mymap['c']=30;

  ret = mymap.equal_range('b');

  assert(ret.first->first == 'b');
  assert(ret.first->second == 20);

  assert(ret.second->first == 'c');
  assert(ret.second->second == 30);
}

static void get_allocator() {
  int psize;
  eastl::vector_map<char, int> mymap;
  eastl::pair<char,int>* p;

  // allocate an array of 5 elements using mymap's allocator:
  p = static_cast<eastl::pair<char,int>*>(mymap.get_allocator().allocate(5));

  // assign some values to array
  psize = (int) sizeof(eastl::vector_map<char, int>::value_type)*5;

  mymap.get_allocator().deallocate(p,5);
}

int main() {
  constructor();
  assign_operator();
  begin_end();
  rbegin_rend();
  empty();
  size();
  max_size();
  index_operator();
  insert();
  erase();
  swap();
  clear();
  key_comp();
  value_comp();
  find();
  count();
  upper_lower_bound();
  equal_range();
  get_allocator();
}
