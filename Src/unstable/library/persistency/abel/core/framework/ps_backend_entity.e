note
	description: "Represents an entity (i.e. a collection or object) within the database."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_BACKEND_ENTITY

inherit
	PS_EIFFELSTORE_EXPORT
		redefine
			is_equal
		end


create {PS_EIFFELSTORE_EXPORT}
	make

feature {PS_EIFFELSTORE_EXPORT} -- Access

	primary_key: INTEGER
			-- The primary key of the entity.

	metadata: PS_TYPE_METADATA
			-- The type of the entity.

feature {PS_EIFFELSTORE_EXPORT} -- Status report

	is_new: BOOLEAN
			-- Has the current entity been freshly generated by the backend?

	is_root: BOOLEAN
			-- Is the current entity a garbage collection root?
		do
			fixme ("Declare as deferred")
		end

	has_type (type: PS_TYPE_METADATA): BOOLEAN
			-- Is `Current.metadata' equal to `type'?
		do
			Result := metadata.is_equal (type)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := primary_key.is_equal (other.primary_key) and metadata.is_equal (other.metadata)
		end

feature {PS_EIFFELSTORE_EXPORT} -- Element change

	set_is_root (value: BOOLEAN)
			-- Set `is_root' to `value'.
		do
			fixme ("Declare as deferred")
		end

	declare_as_old
			-- Set `is_new' to `False'
		do
			is_new := False
		ensure
			is_old: not is_new
		end

feature {NONE} -- Initialization

	make (key: INTEGER; type: PS_TYPE_METADATA)
			-- Initialization for `Current'.
		do
			primary_key := key
			metadata := type
		ensure
			key_set: primary_key = key
			metadata_set: metadata.is_equal (type)
			not_fresh: not is_new
		end

	make_fresh (key: INTEGER; type: PS_TYPE_METADATA)
			-- Initialization for `Current'.
		do
			make (key, type)
			is_new := True
		ensure
			key_set: primary_key = key
			metadata_set: metadata.is_equal (type)
			fresh: is_new
		end

feature {PS_EIFFELSTORE_EXPORT} -- Constants

	root_key: STRING = "ps_is_root"

end