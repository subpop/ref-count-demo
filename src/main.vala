/* main.vala
 *
 * Copyright 2023 Link Dupont
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

/**
 * new_object returns a reference to a newly allocated object, but does not
 * assign it to a local variable. Therefore, this does not leak a reference.
 */
Object new_object () {
	return new Object ();
}

/**
 * new_unowned returns a reference to an object, but declaring it as an unowned
 * return value, this does not leak a reference to the object; the ref_count of
 * the object returned by this function is not increased.
 */
unowned Object new_unowned () {
	Object o = new Object ();
	stdout.printf ("o is a temporary reference to an object in a function, new_unowned\n");
	stdout.printf ("o (%p).ref_count: %u\n", o, o.ref_count);
	return o.ref ();
}

/**
 * new_ref returns a new reference to an object allocated within the function.
 * This leaks a ref to the object inside the function, because we longer have
 * access to the original variable within the function.
 */
Object new_ref () {
	Object r = new Object ();
	stdout.printf ("r is a temporary reference to an object in a function, new_ref\n");
	stdout.printf ("r (%p).ref_count: %u\n", r, r.ref_count);
	return r.ref ();
}

/**
 * new_ownership_transfer returns a reference to an object allocated within the
 * function, but it does not leak a reference; as soon as s goes out of scope,
 * it unrefs, maintaining a reference count of 1.
 */
Object new_ownership_transfer () {
	Object s = new Object ();
	stdout.printf ("s is a temporary reference to an object in the function new_ownership_transfer\n");
	stdout.printf ("s (%p).ref_count: %u\n", s, s.ref_count);
	return s;
}

int main (string[] args)
{
    Object first = new Object ();
	stdout.printf ("first is an owned reference to an instance of type Object\n");
	stdout.printf ("first (%p).ref_count: %u\n", first, first.ref_count);
	
	Object second = first;
	stdout.printf ("second is a second reference to the same instance as first\n");
	stdout.printf ("first (%p).ref_count: %u\n", first, first.ref_count);
	stdout.printf ("second (%p).ref_count: %u\n", second, second.ref_count);

	Object third = new_object ();
	stdout.printf ("third is allocated through a function, new_object, that returns a reference\n");
	stdout.printf ("third (%p).ref_count: %u\n", third, third.ref_count);

	unowned Object fourth = new_unowned ();
	stdout.printf ("fourth is a reference to the unowned reference returned by new_object\n");
	stdout.printf ("fourth (%p).ref_count: %u\n", fourth, fourth.ref_count);

	Object fifth = new_ref ();
	stdout.printf ("fifth is a reference to the object returned by new_ref\n");
	stdout.printf ("fourth (%p).ref_count: %u\n", fifth, fifth.ref_count);

	Object sixth = new_ownership_transfer ();
	stdout.printf ("sixth is a reference to the object returned by new_ownership_transfer\n");
	stdout.printf ("sixth (%p).ref_count: %u\n", sixth, sixth.ref_count);

	return 0;
}
