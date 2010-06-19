/*
 * Copyright (c) 2009 the original author or authors
 *
 * Permission is hereby granted to use, modify, and distribute this file
 * in accordance with the terms of the license agreement accompanying it.
 */

package org.robotlegs.demos.acmewidgetfactory.common.interfaces
{
	import org.robotlegs.core.IContext;
	
	public interface IContextProvider
	{
		function getContext():IContext;
	}
}