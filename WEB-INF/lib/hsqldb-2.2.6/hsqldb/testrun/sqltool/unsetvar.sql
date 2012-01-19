/*
 * $Id: unsetvar.sql 4432 2011-10-01 04:07:19Z unsaved $
 *
 * Invokes another script that defines variables.
 * Then we test that we have access to the variables.
 */

\p *{:unsetvar}

*if (*x != *y)
    \q Two unset variables are not equal
*end if

*x =
*if (*x != *y)
    \q A variable set to '' not equal to an unset variable
*end if
