package org.ranji.lemon.service.liquid.authority.impl;

import java.util.List;

import org.ranji.lemon.common.core.service.impl.GenericServiceImpl;
import org.ranji.lemon.model.liquid.authority.Resource;
import org.ranji.lemon.persist.liquid.authority.prototype.IResourceDao;
import org.ranji.lemon.service.liquid.authority.prototype.IResourceService;
import org.springframework.stereotype.Service;

@Service
public class ResourceServiceImpl extends GenericServiceImpl<Resource, Integer> implements IResourceService {

	@Override
	public List<Integer> findROsByResourceId(int resourceId) {
		
		return ((IResourceDao)dao).findROsByResourceId(resourceId);
	}

}
