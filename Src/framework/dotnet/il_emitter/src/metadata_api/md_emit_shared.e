note
	description: "Summary description for {MD_EMIT_SHARED}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MD_EMIT_SHARED

inherit

	MD_TOKEN_TYPES

feature -- Access

	tables: SPECIAL [MD_TABLES]
			--  in-memory metadata tables

	pe_writer: PE_WRITER
			-- class to generate the PE file.
			--| using as a helper class to access needed features.
			--| TODO, we don't need the full class we need to extract the needed features.

	pe_index: NATURAL_64
			-- metatable index in the PE file for this data container.

	Heap_size_: INTEGER = 65536
			--   If the maximum size of the heap is less than 2^16, then the heap offset size is 2 bytes (16 bits), otherwise it is 4 bytes

feature -- Status report

	us_heap_size: NATURAL_64
			-- User string heap size.
		do
			Result := pe_writer.us.size
		end

	guid_heap_size: NATURAL_64
			-- Guid heap size
		do
			Result := pe_writer.guid.size
		end

	blob_heap_size: NATURAL_64
			-- Blob heap size
		do
			Result := pe_writer.blob.size
		end

	strings_heap_size: NATURAL_64
			-- String heap size
		do
			Result := pe_writer.strings.size
		end

	table_index_size (a_index: PE_TABLES): INTEGER
			-- Table index size for the given table.
		do
			Result := tables [a_index.value.to_integer_32].table.count
		end

feature {NONE} -- Change tables

	add_table_entry (a_entry: PE_TABLE_ENTRY_BASE): NATURAL_64
			-- add an entry to one of the tables
			-- note the data for the table will be a class inherited from TableEntryBase,
			--  and this class will self-report the table index to use
		local
			n: INTEGER
		do
			n := a_entry.table_index
			tables [n].table.force (a_entry)
			Result := tables [n].table.count.to_natural_32
			last_token := (n |<< 24).to_natural_32 | Result.to_natural_32
		end

	last_token: NATURAL_32

feature {NONE} -- Helper

	extract_table_type_and_row (a_token: INTEGER): TUPLE [table_type_index: NATURAL_64; table_row_index: NATURAL_64]
			-- Given a token `a_token' return a TUPLE with the table_type_index and the
			-- table_row_index.
			--| Metadata tokens
			--| Many CIL instructions are followed by a "metadata token". This is a 4-byte value, that specifies a
			--| row in a metadata table, or a starting byte offset in the User String heap. The most-significant
			--| byte of the token specifies the table or heap. For example, a value of 0x02 specifies the TypeDef
			--| table; a value of 0x70 specifies the User String heap. The value corresponds to the number
			--| assigned to that metadata table (see Partition II for the full list of tables) or to 0x70 for the User
			--| String heap. The least-significant 3 bytes specify the target row within that metadata table, or
			--| starting byte offset within the User String heap. The rows within metadata tables are numbered
			--| one upwards, whilst offsets in the heap are numbered zero upwards. (So, for example, the
			--| metadata token with value 0x02000007 specifies row number 7 in the TypeDef table)
		local
			l_table_type_index: NATURAL_64
			l_table_row_index: NATURAL_64
		do
				-- 2^8 -1 = 255
			l_table_type_index := ((a_token |>> 24) & 255).to_natural_64
				-- 2^ 24 -1 = 16777215
			l_table_row_index := (a_token & 16777215).to_natural_64
			Result := [l_table_type_index, l_table_row_index]
		end

	create_method_def_or_ref (a_token: INTEGER; a_index: NATURAL_64): PE_METHOD_DEF_OR_REF
		local
			l_tag: INTEGER
		do
			if a_token & Md_mask = Md_method_def
			then
				l_tag := {PE_METHOD_DEF_OR_REF}.methoddef
			elseif a_token & Md_mask = Md_member_ref
			then
				l_tag := {PE_METHOD_DEF_OR_REF}.memberref
			else
				l_tag := 0
			end
			create Result.make_with_tag_and_index (l_tag, a_index)
		end

	create_type_def_or_ref (a_token: INTEGER; a_index: NATURAL_64): PE_TYPEDEF_OR_REF
		local
			l_tag: INTEGER
		do
			if a_token & Md_mask = Md_type_def
			then
				l_tag := {PE_TYPEDEF_OR_REF}.typedef
			elseif a_token & Md_mask = Md_type_ref
			then
				l_tag := {PE_TYPEDEF_OR_REF}.typeref
			elseif a_token & Md_mask = Md_type_spec then
				l_tag := {PE_TYPEDEF_OR_REF}.typespec
			else
				l_tag := 0
			end
			create Result.make_with_tag_and_index (l_tag, a_index)
		end

	create_member_ref (a_token: INTEGER; a_index: NATURAL_64): PE_MEMBER_REF_PARENT
		local
			l_tag: INTEGER
		do
			if a_token & Md_mask = Md_type_def
			then
				l_tag := {PE_MEMBER_REF_PARENT}.typedef
			elseif a_token & Md_mask = Md_type_ref
			then
				l_tag := {PE_MEMBER_REF_PARENT}.typeref
			elseif a_token & Md_mask = Md_type_spec then
				l_tag := {PE_MEMBER_REF_PARENT}.typespec
			elseif a_token & Md_mask = Md_module_ref then
				l_tag := {PE_MEMBER_REF_PARENT}.moduleref
			elseif a_token & Md_mask = Md_method_def then
				l_tag := {PE_MEMBER_REF_PARENT}.methoddef
			else
				l_tag := 0
			end
			create Result.make_with_tag_and_index (l_tag, a_index)
		end

	create_implementation (a_token: INTEGER; a_index: NATURAL_64): PE_IMPLEMENTATION
		local
			l_tag: INTEGER
		do
			if a_token & Md_mask = Md_file then
				l_tag := {PE_IMPLEMENTATION}.File
			elseif a_token & Md_mask = Md_assembly_ref then
				l_tag := {PE_IMPLEMENTATION}.AssemblyRef
			else
				l_tag := 0
			end
			create Result.make_with_tag_and_index (l_tag, a_index)
		end

	create_pe_custom_attribute (a_token: INTEGER; a_index: NATURAL_64): PE_CUSTOM_ATTRIBUTE
		local
			l_tag: INTEGER
		do
			if a_token & Md_mask = Md_method_def then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.MethodDef
			elseif a_token & Md_mask = Md_field_def then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.FieldDef
			elseif a_token & Md_mask = Md_type_ref then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.TypeRef
			elseif a_token & Md_mask = Md_type_def then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.TypeDef
			elseif a_token & Md_mask = Md_param_def then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.ParamDef
			elseif a_token & Md_mask = Md_interface_impl then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.InterfaceImpl
			elseif a_token & Md_mask = Md_member_ref then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.MemberRef
			elseif a_token & Md_mask = Md_module then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.Module
			elseif a_token & Md_mask = Md_permission then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.Permission
			elseif a_token & Md_mask = Md_property then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.Property
			elseif a_token & Md_mask = Md_event then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.Event
			elseif a_token & Md_mask = Md_signature then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.StandaloneSig
			elseif a_token & Md_mask = Md_module_ref then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.ModuleRef
			elseif a_token & Md_mask = Md_type_spec then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.TypeSpec
			elseif a_token & Md_mask = Md_assembly then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.Assembly
			elseif a_token & Md_mask = Md_assembly_ref then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.AssemblyRef
			elseif a_token & Md_mask = Md_file then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.File
			elseif a_token & Md_mask = Md_exported_type then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.ExportedType
			elseif a_token & Md_mask = Md_manifest_resource then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.ManifestResource
			else
				l_tag := 0
			end
			create Result.make_with_tag_and_index (l_tag, a_index)
		end

	create_pe_custom_attribute_type (a_token: INTEGER; a_index: NATURAL_64): PE_CUSTOM_ATTRIBUTE_TYPE
		local
			l_tag: INTEGER
		do
			if a_token & Md_mask = Md_method_def then
				l_tag := {PE_CUSTOM_ATTRIBUTE_TYPE}.MethodDef
			elseif a_token & Md_mask = md_member_ref then
				l_tag := {PE_CUSTOM_ATTRIBUTE_TYPE}.MemberRef
			else
				l_tag := 0
			end
			create Result.make_with_tag_and_index (l_tag, a_index)
		end

feature -- Metadata Table Sizes

	module_table_entry_size: INTEGER
		note
			EIS: "name={PE_MODULE_TABLE_ENTRY}.name_index", "src=eiffel:?class=PE_MODULE_TABLE_ENTRY&feature=name_index", "protocol=uri"
			EIS: "name={PE_MODULE_TABLE_ENTRY}.guid_index", "src=eiffel:?class=PE_MODULE_TABLE_ENTRY&feature=guid_index"
		do
				-- Size of the name column.
			Result := if strings_heap_size < 65536 then 2 else 4 end
				-- Size of guid column
			Result := Result + if guid_heap_size < 65536 then 2 else 4 end
		end

	type_ref_entry_size: INTEGER
			-- Compute the table entry size for the TypeRef table
		note
			EIS: "name={PE_TYPE_REF_TABLE_ENTRY}.resolution", "protocol=uri", "src=eiffel:?class=PE_TYPE_REF_ENTRY&feature=resolution"
			EIS: "name={PE_TYPE_REF_TABLE_ENTRY}.type_name_index", "protocol=uri", "src=eiffel:?class=PE_TYPE_REF_ENTRY&feature=type_name_index"
			EIS: "name={PE_TYPE_REF_TABLE_ENTRY}.type_name_space_index", "protocol=uri", "src=eiffel:?class=PE_TYPE_REF_ENTRY&feature=type_name_space_index"

		local
			index_size, heap_offset_size: INTEGER
		do
				-- Resolution scope
			if pe_index.to_integer_32 < 65536 then
				index_size := 2
			else
				index_size := 4
			end

				-- Type name index and type_name_space_index
			if strings_heap_size < 65536 then
				heap_offset_size := 2
			else
				heap_offset_size := 4
			end

			Result := index_size + 2 * heap_offset_size
		end

	type_def_table_entry_size: INTEGER
			-- Compute the table entry size for the TypeDef table
		note
			EIS: "name={PE_TYPE_DEF_TABLE_ENTRY}.type_name_index", "protocol=uri", "src=eiffel:?class=PE_TYPE_DEF_TABLE_ENTRY&feature=type_name_index"
			EIS: "name={PE_TYPE_DEF_TABLE_ENTRY}.type_name_space_index", "protocol=uri", "src=eiffel:?class=PE_TYPE_DEF_TABLE_ENTRY&feature=type_name_space_index"
			EIS: "name={PE_TYPE_DEF_TABLE_ENTRY}.extends", "protocol=uri", "src=eiffel:?class=PE_TYPE_DEF_TABLE_ENTRY&feature=extends"
			EIS: "name={PE_TYPE_DEF_TABLE_ENTRY}.fields", "protocol=uri", "src=eiffel:?class=PE_TYPE_DEF_TABLE_ENTRY&feature=fields"
			EIS: "name={PE_TYPE_DEF_TABLE_ENTRY}.methods", "protocol=uri", "src=eiffel:?class=PE_TYPE_DEF_TABLE_ENTRY&feature=methods"
		local
			index_size, heap_offset_size: INTEGER
		do
				-- extends, fields and methods
			if pe_index.to_integer_32 < 65536 then
				index_size := 2
			else
				index_size := 4
			end

				-- type_name_index and type_name_space_index
			if strings_heap_size < 65536 then
				heap_offset_size := 2
			else
				heap_offset_size := 4
			end

				-- 4 is the size of the flags
			Result := 4 + 2 * heap_offset_size + 3 * index_size
		end

	field_table_entry_size: INTEGER
			-- Compute the table entry size for the Field table
		note
			EIS: "name={PE_FIELD_TABLE_ENTRY}.flags", "src=eiffel:?class=PE_FIELD_TABLE_ENTRY&feature=flags"
			EIS: "name={PE_FIELD_TABLE_ENTRY}.name_index", "src=eiffel:?class=PE_FIELD_TABLE_ENTRY&feature=name_index"
			EIS: "name={PE_FIELD_TABLE_ENTRY}.signature_index", "src=eiffel:?class=PE_FIELD_TABLE_ENTRY&feature=signature_index"

		local
			string_offset_size, blob_offset_size: INTEGER
		do
				-- Name
			if strings_heap_size < 65536 then
				string_offset_size := 2
			else
				string_offset_size := 4
			end

				-- Signature
			if blob_heap_size < 65536 then
				blob_offset_size := 2
			else
				blob_offset_size := 4
			end

				-- Flags (a 2-byte bitmask of type FieldAttributes)
				-- Name (an index into the String heap)
				-- Signature (an index into the Blob heap)
			Result := 2 + string_offset_size + blob_offset_size
		end

	method_def_table_entry_size: INTEGER
			-- Compute the table entry size for the MethodDef table
		note
			EIS: "name={PE_METHOD_DEF_TABLE_ENTRY}.rva", "protocol=uri", "src=eiffel:?class=PE_METHOD_DEF_TABLE_ENTRY&feature=rva"
			EIS: "name={PE_METHOD_DEF_TABLE_ENTRY}.impl_flags", "protocol=uri", "src=eiffel:?class=PE_METHOD_DEF_TABLE_ENTRY&feature=impl_flags"
			EIS: "name={PE_METHOD_DEF_TABLE_ENTRY}.flags", "protocol=uri", "src=eiffel:?class=PE_METHOD_DEF_TABLE_ENTRY&feature=flags"
			EIS: "name={PE_METHOD_DEF_TABLE_ENTRY}.name_index", "protocol=uri", "src=eiffel:?class=PE_METHOD_DEF_TABLE_ENTRY&feature=name_index"
			EIS: "name={PE_METHOD_DEF_TABLE_ENTRY}.signature_index", "protocol=uri", "src=eiffel:?class=PE_METHOD_DEF_TABLE_ENTRY&feature=signature_index"
			EIS: "name={PE_METHOD_DEF_TABLE_ENTRY}.param_index", "protocol=uri", "src=eiffel:?class=PE_METHOD_DEF_TABLE_ENTRY&feature=param_index"
		local
			index_size, string_heap_offset_size, blob_heap_offset_size: INTEGER
		do
				-- param_index
			if pe_index.to_integer_32 < 65536 then
				index_size := 2
			else
				index_size := 4
			end

				-- name_index
			if strings_heap_size < 65536 then
				string_heap_offset_size := 2
			else
				string_heap_offset_size := 4
			end

				-- signature_index
			if blob_heap_size < 65536 then
				blob_heap_offset_size := 2
			else
				blob_heap_offset_size := 4
			end
				-- Size of rva column 4
				-- Size of impl_flags column 2
				-- Size of flags column 2
				-- 8
			Result := 8 + string_heap_offset_size + blob_heap_offset_size + index_size
		end

	param_table_entry_size: INTEGER
			-- Compute the table entry size for the Param table
		note
			EIS: "name={PE_PARAM_TABLE_ENTRY}.flags", "protocol=uri", "src=eiffel:?class=PE_PARAM_TABLE_ENTRY&feature=flags"
			EIS: "name={PE_PARAM_TABLE_ENTRY}.sequence_index", "protocol=uri", "src=eiffel:?class=PE_PARAM_TABLE_ENTRY&feature=sequence_index"
			EIS: "name={PE_PARAM_TABLE_ENTRY}.name_index", "protocol=uri", "src=eiffel:?class=PE_PARAM_TABLE_ENTRY&feature=name_index"
		local
			index_size: INTEGER
		do
				-- name_index
			if strings_heap_size < 65536 then
				index_size := 2
			else
				index_size := 4
			end

				-- Size of flags column 2
				-- Size of sequence_index column 2
				-- 4
			Result := 4 + index_size
		end

	interface_impl_table_entry_size: INTEGER
			-- Compute the table entry size for the InterfaceImpl table
		note
			EIS: "name={PE_INTERFACE_IMPL_TABLE_ENTRY}.class_", "protocol=uri", "src=eiffel:?class=PE_INTERFACE_IMPL_TABLE_ENTRY&feature=class_"
			EIS: "name={PE_INTERFACE_IMPL_TABLE_ENTRY}.interface", "protocol=uri", "src=eiffel:?class=PE_INTERFACE_IMPL_TABLE_ENTRY&feature=interface"
			-- Compute the table entry size for the InterfaceImpl table
		local
			index_size: INTEGER
		do
			if pe_index.to_integer_32 < 65536 then
				index_size := 2
			else
				index_size := 4
			end

				-- Size of class_ and interface index..
			Result := 2 * index_size
		end

	member_ref_table_entry_size: INTEGER
			-- Compute the table entry size for the MemberRef table
		note
			EIS: "name={PE_MEMBER_REF_TABLE_ENTRY}.parent_index", "protocol=uri", "src=eiffel:?class=PE_MEMBER_REF_TABLE_ENTRY&feature=parent_index"
			EIS: "name={PE_MEMBER_REF_TABLE_ENTRY}.name_index", "protocol=uri", "src=eiffel:?class=PE_MEMBER_REF_TABLE_ENTRY&feature=name_index"
			EIS: "name={PE_MEMBER_REF_TABLE_ENTRY}.signature", "protocol=uri", "src=eiffel:?class=PE_MEMBER_REF_TABLE_ENTRY&feature=signature"
		local
			index_size, string_heap_offset_size, blob_heap_offset_size: INTEGER
		do
				-- parent_index or class_index see spec.
			if pe_index.to_integer_32 < 65536 then
				index_size := 2
			else
				index_size := 4
			end

				-- name_index
			if strings_heap_size < 65536 then
				string_heap_offset_size := 2
			else
				string_heap_offset_size := 4
			end

				-- signature_index
			if blob_heap_size < 65536 then
				blob_heap_offset_size := 2
			else
				blob_heap_offset_size := 4
			end

			Result := index_size + string_heap_offset_size + blob_heap_offset_size
		end

	constant_table_entry_size: INTEGER
			-- Compute the table entry size for the Constant table
		note
			EIS: "name={PE_CONSTANT_TABLE_ENTRY}.type", "protocol=uri", "src=eiffel:?class=PE_CONSTANT_TABLE_ENTRY&feature=type"
			EIS: "name={PE_CONSTANT_TABLE_ENTRY}.parent_index", "protocol=uri", "src=eiffel:?class=PE_CONSTANT_TABLE_ENTRY&feature=parent_index"
			EIS: "name={PE_CONSTANT_TABLE_ENTRY}.value_index", "protocol=uri", "src=eiffel:?class=PE_CONSTANT_TABLE_ENTRY&feature=value_index"
		local
			index_size, blob_heap_offset_size: INTEGER
		do
				-- parent_index
			if pe_index.to_integer_32 < 65536 then
				index_size := 2
			else
				index_size := 4
			end

				-- value_index
			if blob_heap_size < 65536 then
				blob_heap_offset_size := 2
			else
				blob_heap_offset_size := 4
			end

				-- Size of type column 2 (1 byte for the constant and 1 byte for padding)
				-- 2
			Result := 2 + index_size + blob_heap_offset_size
		end

	custom_attribute_table_entry_size: INTEGER
			-- Compute the table entry size for the CustomAttribute table
		note
			EIS: "name={PE_CUSTOM_ATTRIBUTE_TABLE_ENTRY}.parent_index", "protocol=uri", "src=eiffel:?class=PE_CUSTOM_ATTRIBUTE_TABLE_ENTRY&feature=parent_index"
			EIS: "name={PE_CUSTOM_ATTRIBUTE_TABLE_ENTRY}.type_index", "protocol=uri", "src=eiffel:?class=PE_CUSTOM_ATTRIBUTE_TABLE_ENTRY&feature=type_index"
			EIS: "name={PE_CUSTOM_ATTRIBUTE_TABLE_ENTRY}.value_index", "protocol=uri", "src=eiffel:?class=PE_CUSTOM_ATTRIBUTE_TABLE_ENTRY&feature=value_index"
		local
			index_size, blob_heap_offset_size: INTEGER
		do
				-- parent_index and type_index
			if pe_index.to_integer_32 < 65536 then
				index_size := 2
			else
				index_size := 4
			end

				-- value_index
			if blob_heap_size < 65536 then
				blob_heap_offset_size := 2
			else
				blob_heap_offset_size := 4
			end

			Result := 2 * index_size + blob_heap_offset_size
		end

	field_marshal_table_entry_size: INTEGER
			-- Compute the table entry size for the FieldMarshal table
		note
			EIS: "name={PE_FIELD_MARSHAL_TABLE_ENTRY}.parent", "protocol=uri", "src=eiffel:?class=PE_FIELD_MARSHAL_TABLE_ENTRY&feature=parent"
			EIS: "name={PE_FIELD_MARSHAL_TABLE_ENTRY}.native_type", "protocol=uri", "src=eiffel:?class=PE_FIELD_MARSHAL_TABLE_ENTRY&feature=native_type"
		local
			index_size, blob_heap_offset_size: INTEGER
		do
			if pe_index.to_integer_32 < 65536 then
				index_size := 2
			else
				index_size := 4
			end

				-- native_type
			if blob_heap_size < 65536 then
				blob_heap_offset_size := 2
			else
				blob_heap_offset_size := 4
			end

			Result := index_size + blob_heap_offset_size
		end

	decl_security_table_entry_size: INTEGER
			-- Compute the table entry size for the DeclSecurity table
		note
			EIS: "name={PE_DECL_SECURITY_TABLE_ENTRY}.action", "protocol=uri", "src=eiffel:?class=PE_DECL_SECURITY_TABLE_ENTRY&feature=action"
			EIS: "name={PE_DECL_SECURITY_TABLE_ENTRY}.parent", "protocol=uri", "src=eiffel:?class=PE_DECL_SECURITY_TABLE_ENTRY&feature=parent"
			EIS: "name={PE_DECL_SECURITY_TABLE_ENTRY}.permission_set", "protocol=uri", "src=eiffel:?class=PE_DECL_SECURITY_TABLE_ENTRY&feature=permission_set"
		local
			index_size, blob_heap_offset_size: INTEGER
		do
			if pe_index.to_integer_32 < 65536 then
				index_size := 2
			else
				index_size := 4
			end
				-- permission_set
			if blob_heap_size < 65536 then
				blob_heap_offset_size := 2
			else
				blob_heap_offset_size := 4
			end

				-- 2 bytes for action column + sizes of parent and permissionSet columns
			Result := 2 + index_size + blob_heap_offset_size
		end

	class_layout_table_entry_size: INTEGER
			-- Compute the table entry size for the ClassLayout table
		note
			EIS: "name={PE_CLASS_LAYOUT_TABLE_ENTRY}.pack", "protocol=uri", "src=eiffel:?class=PE_CLASS_LAYOUT_TABLE_ENTRY&feature=pack"
			EIS: "name={PE_CLASS_LAYOUT_TABLE_ENTRY}.size", "protocol=uri", "src=eiffel:?class=PE_CLASS_LAYOUT_TABLE_ENTRY&feature=size"
			EIS: "name={PE_CLASS_LAYOUT_TABLE_ENTRY}.parent", "protocol=uri", "src=eiffel:?class=PE_CLASS_LAYOUT_TABLE_ENTRY&feature=parent"
		local
			index_size: INTEGER
		do
			if pe_index.to_integer_32 < 65536 then
				index_size := 2
			else
				index_size := 4
			end

				-- -- 2 bytes for pack column + 4 bytes for size (class size) column + size of parent column
			Result := 2 + 4 + index_size
		end

	field_layout_table_entry_size: INTEGER
			-- Compute the table entry size for the FieldLayout table
		note
			EIS: "name={PE_FIELD_LAYOUT_TABLE_ENTRY}.offset", "protocol=uri", "src=eiffel:?class=PE_FIELD_LAYOUT_TABLE_ENTRY&feature=offset"
			EIS: "name={PE_FIELD_LAYOUT_TABLE_ENTRY}.parent", "protocol=uri", "src=eiffel:?class=PE_FIELD_LAYOUT_TABLE_ENTRY&feature=parent"
		local
			index_size: INTEGER
		do
			if pe_index.to_integer_32 < 65536 then
				index_size := 2
			else
				index_size := 4
			end
				-- 4 bytes for pffset column + size of parent column
			Result := 4 + index_size
		end

	standalone_sig_table_entry_size: INTEGER
			-- Compute the table entry size for the StandAloneSig table.
		note
			EIS: "name={PE_STANDALONE_SIG_TABLE_ENTRY}.signature_index", "protocol=uri", "src=eiffel:?class=PE_STANDALONE_SIG_TABLE_ENTRY&feature=signature_index"
		local
			index_size: INTEGER
		do
			if blob_heap_size < 65536 then
				index_size := 2
			else
				index_size := 4
			end
			Result := index_size
		end

	property_map_table_entry_size: INTEGER
			-- Compute the size of a single entry in the PropertyMap table
		note
			EIS: "name={PE_PROPERTY_MAP_TABLE_ENTRY}.parent", "protocol=uri", "src=eiffel:?class=PE_PROPERTY_MAP_TABLE_ENTRY&feature=parent"
			EIS: "name={PE_PROPERTY_MAP_TABLE_ENTRY}.property_list", "protocol=uri", "src=eiffel:?class=PE_PROPERTY_MAP_TABLE_ENTRY&feature=property_list"
		local
			index_size: INTEGER
		do
				-- parent and property_list
			if pe_index.to_integer_32 < 65536 then
				index_size := 2
			else
				index_size := 4
			end

			Result := 2 * index_size
		end

	property_table_entry_size: INTEGER
			-- Compute the size of a single entry in the Property table
		note
			EIS: "name={PE_PROPERTY_TABLE_ENTRY}.flags", "protocol=uri", "src=eiffel:?class=PE_PROPERTY_TABLE_ENTRY&feature=flags"
			EIS: "name={PE_PROPERTY_TABLE_ENTRY}.name", "protocol=uri", "src=eiffel:?class=PE_PROPERTY_TABLE_ENTRY&feature=name"
			EIS: "name={PE_PROPERTY_TABLE_ENTRY}.property_type", "protocol=uri", "src=eiffel:?class=PE_PROPERTY_TABLE_ENTRY&feature=property_type"

		local
			name_index_size, type_index_size: INTEGER
		do
			if strings_heap_size < 65536 then
				name_index_size := 2
			else
				name_index_size := 4
			end

			if blob_heap_size < 65536 then
				type_index_size := 2
			else
				type_index_size := 4
			end
				-- 2 bytes for flag	+ name index and type index
			Result := 2 + name_index_size + type_index_size
		end

	method_semantics_table_entry_size: INTEGER
			-- Compute the size of a single entry in the MethodSemantics table
		note
			EIS: "name={PE_METHOD_SEMANTICS_TABLE_ENTRY}.semantics", "protocol=uri", "src=eiffel:?class=PE_METHOD_SEMANTICS_TABLE_ENTRY&feature=semantics"
			EIS: "name={PE_METHOD_SEMANTICS_TABLE_ENTRY}.method", "protocol=uri", "src=eiffel:?class=PE_METHOD_SEMANTICS_TABLE_ENTRY&feature=method"
			EIS: "name={PE_METHOD_SEMANTICS_TABLE_ENTRY}.association", "protocol=uri", "src=eiffel:?class=PE_METHOD_SEMANTICS_TABLE_ENTRY&feature=association"

		local
			index_size: INTEGER
		do
				-- method and association
			if pe_index.to_integer_32 < 65536 then
				index_size := 2
			else
				index_size := 4
			end
				-- 2 bytes for semantics column.
			Result := 2 + 2 * index_size
		end

	method_impl_table_entry_size: INTEGER
			-- Compute the size of a single entry in the MethodImpl table
		note
			EIS: "name={PE_METHOD_IMPL_TABLE_ENTRY}.class_", "protocol=uri", "src=eiffel:?class=PE_METHOD_IMPL_TABLE_ENTRY&feature=class_"
			EIS: "name={PE_METHOD_IMPL_TABLE_ENTRY}.method_body", "protocol=uri", "src=eiffel:?class=PE_METHOD_IMPL_TABLE_ENTRY&feature=method_body"
			EIS: "name={PE_METHOD_IMPL_TABLE_ENTRY}.method_declaration", "protocol=uri", "src=eiffel:?class=PE_METHOD_IMPL_TABLE_ENTRY&feature=method_declaration"

		local
			index_size: INTEGER
		do
			if pe_index.to_integer_32 < 65536 then
				index_size := 2
			else
				index_size := 4
			end

			Result := 3 * index_size
		end

	module_ref_table_entry_size: INTEGER
			-- Compute the size of a single entry in the ModuleRef table.
		note
			EIS: "name={PE_MODULE_REF_TABLE_ENTRY}.name_index", "protocol=uri", "src=eiffel:?class=PE_MODULE_REF_TABLE_ENTRY&feature=name_index"
		local
			index_size: INTEGER
		do
			if strings_heap_size < 65536 then
				index_size := 2
			else
				index_size := 4
			end
			Result := index_size
		end

	type_spec_table_entry_size: INTEGER
			-- Compute the table entry size for the TypeSpec table
		note
			EIS: "name={PE_TYPE_SPEC_TABLE_ENTRY}.signature_index", "protocol=uri", "src=eiffel:?class=PE_TYPE_SPEC_TABLE_ENTRY&feature=signature_index"
		local
			index_size: INTEGER
		do
			if blob_heap_size < 65536 then
				index_size := 2
			else
				index_size := 4
			end
				-- size of Signature column (an index into the Blob heap)
			Result := index_size
		end

	impl_map_table_entry_size: INTEGER
			-- Compute the table entry size for the ImplMap table.
		note
			EIS: "name={PE_IMPL_MAP_TABLE_ENTRY}.flags", "protocol=uri", "src=eiffel:?class=PE_IMPL_MAP_TABLE_ENTRY&feature=flags"
			EIS: "name={PE_IMPL_MAP_TABLE_ENTRY}.method_index", "protocol=uri", "src=eiffel:?class=PE_IMPL_MAP_TABLE_ENTRY&feature=method_index"
			EIS: "name={PE_IMPL_MAP_TABLE_ENTRY}.import_name_index", "protocol=uri", "src=eiffel:?class=PE_IMPL_MAP_TABLE_ENTRY&feature=import_name_index"
			EIS: "name={PE_IMPL_MAP_TABLE_ENTRY}.module_index", "protocol=uri", "src=eiffel:?class=PE_IMPL_MAP_TABLE_ENTRY&feature=module_index"
		local
			index_size, string_index_size: INTEGER
		do
				-- method_index MemberForwarded and
				-- module_index ImportScope
			if pe_index < 65536 then
				index_size := 2
			else
				index_size := 4
			end

				-- import_name_index Index ImportName
			if strings_heap_size < 65536 then
				string_index_size := 2
			else
				string_index_size := 4
			end

				-- 2 bytes for MappingFlags column + size of MemberForwarded column + size of ImportName column + size of ImportScope column
			Result := 2 + 2 * index_size + string_index_size
		end

	field_rva_table_entry_size: INTEGER
			-- Compute the table entry size for the FieldRVA table
		note
			EIS: "name={PE_FIELD_RVA_TABLE_ENTRY}.rva", "protocol=uri", "src=eiffel:?class=PE_FIELD_RVA_TABLE_ENTRY&feature=rva"
			EIS: "name={PE_FIELD_RVA_TABLE_ENTRY}.field_index", "protocol=uri", "src=eiffel:?class=PE_FIELD_RVA_TABLE_ENTRY&feature=field_index"
		local
			index_size: INTEGER
		do
			if pe_index.to_integer_32 < 65536 then
				index_size := 2
			else
				index_size := 4
			end
				-- -- 4 bytes for RVA column + size of Field column
			Result := 4 + index_size
		end

	assembly_table_entry_size: INTEGER
			-- Compute the table entry size for the Assembly table
		note
			EIS: "name={PE_ASSEMBLY_TABLE_ENTRY}.hash_alg_id", "protocol=uri", "src=eiffel:?class=PE_ASSEMBLY_TABLE_ENTRY&feature=hash_alg_id"
			EIS: "name={PE_ASSEMBLY_TABLE_ENTRY}.major", "protocol=uri", "src=eiffel:?class=PE_ASSEMBLY_TABLE_ENTRY&feature=major"
			EIS: "name={PE_ASSEMBLY_TABLE_ENTRY}.minor", "protocol=uri", "src=eiffel:?class=PE_ASSEMBLY_TABLE_ENTRY&feature=minor"
			EIS: "name={PE_ASSEMBLY_TABLE_ENTRY}.build", "protocol=uri", "src=eiffel:?class=PE_ASSEMBLY_TABLE_ENTRY&feature=build"
			EIS: "name={PE_ASSEMBLY_TABLE_ENTRY}.revision", "protocol=uri", "src=eiffel:?class=PE_ASSEMBLY_TABLE_ENTRY&feature=revision"
			EIS: "name={PE_ASSEMBLY_TABLE_ENTRY}.flags", "protocol=uri", "src=eiffel:?class=PE_ASSEMBLY_TABLE_ENTRY&feature=flags"
			EIS: "name={PE_ASSEMBLY_TABLE_ENTRY}.public_key", "protocol=uri", "src=eiffel:?class=PE_ASSEMBLY_TABLE_ENTRY&feature=public_key"
			EIS: "name={PE_ASSEMBLY_TABLE_ENTRY}.name_index", "protocol=uri", "src=eiffel:?class=PE_ASSEMBLY_TABLE_ENTRY&feature=name_index"
			EIS: "name={PE_ASSEMBLY_TABLE_ENTRY}.culture_index", "protocol=uri", "src=eiffel:?class=PE_ASSEMBLY_TABLE_ENTRY&feature=culture_index"
		local
			blob_index_size, string_index_size: INTEGER
		do
				-- PublicKey
			if blob_heap_size < 65536 then
				blob_index_size := 2
			else
				blob_index_size := 4
			end
				-- Name and Culture.
			if strings_heap_size < 65536 then
				string_index_size := 2
			else
				string_index_size := 4
			end

				-- 4 bytes for HashAlgId column
				-- 2 bytes for each of MajorVersion, MinorVersion, BuildNumber, and RevisionNumber columns
				-- 4 bytes for Flags column
				-- size of PublicKey
				-- size of NameIndex
				-- size of CultureIndex.
			Result := 4 + (2 * 4) + 4 + blob_index_size + 2 * string_index_size
		end

	assembly_ref_table_entry_size: INTEGER
			-- Compute the table entry size for the AssemblyRef table
		note
			EIS: "name={PE_ASSEMBLY_REF_TABLE_ENTRY}.major", "protocol=uri", "src=eiffel:?class=PE_ASSEMBLY_REF_TABLE_ENTRY&feature=major"
			EIS: "name={PE_ASSEMBLY_REF_TABLE_ENTRY}.minor", "protocol=uri", "src=eiffel:?class=PE_ASSEMBLY_REF_TABLE_ENTRY&feature=minor"
			EIS: "name={PE_ASSEMBLY_REF_TABLE_ENTRY}.build", "protocol=uri", "src=eiffel:?class=PE_ASSEMBLY_REF_TABLE_ENTRY&feature=build"
			EIS: "name={PE_ASSEMBLY_REF_TABLE_ENTRY}.revision", "protocol=uri", "src=eiffel:?class=PE_ASSEMBLY_REF_TABLE_ENTRY&feature=revision"
			EIS: "name={PE_ASSEMBLY_REF_TABLE_ENTRY}.flags", "protocol=uri", "src=eiffel:?class=PE_ASSEMBLY_REF_TABLE_ENTRY&feature=flags"
			EIS: "name={PE_ASSEMBLY_REF_TABLE_ENTRY}.public_key_index", "protocol=uri", "src=eiffel:?class=PE_ASSEMBLY_REF_TABLE_ENTRY&feature=public_key_index"
			EIS: "name={PE_ASSEMBLY_REF_TABLE_ENTRY}.name_index", "protocol=uri", "src=eiffel:?class=PE_ASSEMBLY_REF_TABLE_ENTRY&feature=name_index"
			EIS: "name={PE_ASSEMBLY_REF_TABLE_ENTRY}.culture_index", "protocol=uri", "src=eiffel:?class=PE_ASSEMBLY_REF_TABLE_ENTRY&feature=culture_index"
			EIS: "name={PE_ASSEMBLY_REF_TABLE_ENTRY}.hash_index", "protocol=uri", "src=eiffel:?class=PE_ASSEMBLY_REF_TABLE_ENTRY&feature=hash_index"
		local
			blob_index_size, string_index_size: INTEGER
		do
				-- public_key_index
				-- hash_index
			if blob_heap_size < 65536 then
				blob_index_size := 2
			else
				blob_index_size := 4
			end
				-- name_index
				-- culture_index
			if strings_heap_size < 65536 then
				string_index_size := 2
			else
				string_index_size := 4
			end

				-- 2 bytes for each of MajorVersion, MinorVersion, BuildNumber, and RevisionNumber columns
				-- 4 bytes for Flags column
				-- size of PublicKeyOrToken column
				-- size of Name column
				-- size of Culture column
				-- size of HashValue column
			Result := (2 * 4) + 4 + 2 * blob_index_size + 2 * string_index_size
		end

	file_table_entry_size: INTEGER
			-- Compute the table entry size for the File table
		note
			EIS: "name={PE_FILE_TABLE_ENTRY}.flags", "protocol=uri", "src=eiffel:?class=PE_FILE_TABLE_ENTRY&feature=flags"
			EIS: "name={PE_FILE_TABLE_ENTRY}.name", "protocol=uri", "src=eiffel:?class=PE_FILE_TABLE_ENTRY&feature=name"
			EIS: "name={PE_FILE_TABLE_ENTRY}.hash", "protocol=uri", "src=eiffel:?class=PE_FILE_TABLE_ENTRY&feature=hash"
		local
			blob_offset_size, string_offset_size: INTEGER
		do
				-- Name
			if strings_heap_size < 65536 then
				string_offset_size := 2
			else
				string_offset_size := 4
			end

				-- Hash Value
			if blob_heap_size < 65536 then
				blob_offset_size := 2
			else
				blob_offset_size := 4
			end

				-- Flags (a 4-byte bitmask of type FileAttributes)
				-- Name (an index into the String heap)
				-- HashValue (an index into the Blob heap)
			Result := 4 + string_offset_size + blob_offset_size
		end

	exported_type_table_entry_size: INTEGER
			-- Compute the table entry size for the ExportedType table
		note
			EIS: "name={PE_EXPORTED_TYPE_TABLE_ENTRY}.flags", "protocol=uri", "src=eiffel:?class=PE_EXPORTED_TYPE_TABLE_ENTRY&feature=flags"
			EIS: "name={PE_EXPORTED_TYPE_TABLE_ENTRY}.type_def_id", "protocol=uri", "src=eiffel:?class=PE_EXPORTED_TYPE_TABLE_ENTRY&feature=type_def_id"
			EIS: "name={PE_EXPORTED_TYPE_TABLE_ENTRY}.type_name", "protocol=uri", "src=eiffel:?class=PE_EXPORTED_TYPE_TABLE_ENTRY&feature=type_name"
			EIS: "name={PE_EXPORTED_TYPE_TABLE_ENTRY}.type_name_space", "protocol=uri", "src=eiffel:?class=PE_EXPORTED_TYPE_TABLE_ENTRY&feature=type_name_space"
			EIS: "name={PE_EXPORTED_TYPE_TABLE_ENTRY}.implementation", "protocol=uri", "src=eiffel:?class=PE_EXPORTED_TYPE_TABLE_ENTRY&feature=implementation"
		local
			string_offset_size, index_size: INTEGER
		do
				-- TypeName and TypeNamespace
			if strings_heap_size < 65536 then
				string_offset_size := 2
			else
				string_offset_size := 4
			end

				-- Implementation
			if pe_index.to_integer_32 < 65536 then
				index_size := 2
			else
				index_size := 4
			end

				-- Flags (a 4-byte bitmask of type TypeAttributes)
				-- TypeDefId (a 4-byte index into a TypeDef table of another module in this Assembly)
				-- TypeName (an index into the String heap)
				-- TypeNamespace (an index into the String heap)
				-- Implementation (an Implementation coded index into either the File table,
				-- the ExportedType table, or the AssemblyRef table)
			Result := 4 + 4 + 2 * string_offset_size + index_size
		end

	manifest_resource_table_entry_size: INTEGER
			-- Compute the table entry size for the ManifestResource table
		note
			EIS: "name={PE_MANIFEST_RESOURCE_TABLE_ENTRY}.offset", "protocol=uri", "src=eiffel:?class=PE_MANIFEST_RESOURCE_TABLE_ENTRY&feature=offset"
			EIS: "name={PE_MANIFEST_RESOURCE_TABLE_ENTRY}.flags", "protocol=uri", "src=eiffel:?class=PE_MANIFEST_RESOURCE_TABLE_ENTRY&feature=flags"
			EIS: "name={PE_MANIFEST_RESOURCE_TABLE_ENTRY}.name", "protocol=uri", "src=eiffel:?class=PE_MANIFEST_RESOURCE_TABLE_ENTRY&feature=name"
			EIS: "name={PE_MANIFEST_RESOURCE_TABLE_ENTRY}.implementation", "protocol=uri", "src=eiffel:?class=PE_MANIFEST_RESOURCE_TABLE_ENTRY&feature=implementation"

		local
			string_offset_size, index_size: INTEGER
		do
				-- Name
			if strings_heap_size < 65536 then
				string_offset_size := 2
			else
				string_offset_size := 4
			end

				-- Implementation
			if pe_index.to_integer_32 < 65536 then
				index_size := 2
			else
				index_size := 4
			end

				-- Offset (a 4-byte constant)
				-- Flags (a 4-byte bitmask of type ManifestResourceAttributes)
				-- Name (an index into the String heap)
				-- Implementation (an Implementation coded index into either the File table,
				-- the AssemblyRef table, or null)
			Result := 4 + 4 + string_offset_size + index_size
		end

	nested_class_table_entry_size: INTEGER
			-- Compute the table entry size for the NestedClass table
		note
			EIS: "name={PE_NESTED_CLASS_TABLE_ENTRY}.nested_index", "protocol=uri", "src=eiffel:?class=PE_NESTED_CLASS_TABLE_ENTRY&feature=nested_index"
			EIS: "name={PE_NESTED_CLASS_TABLE_ENTRY}.enclosing_index", "protocol=uri", "src=eiffel:?class=PE_NESTED_CLASS_TABLE_ENTRY&feature=enclosing_index"
		local
			index_size: INTEGER
		do
				-- NestedClass and EnclosingClass
			if pe_index.to_integer_32 < 65536 then
				index_size := 2
			else
				index_size := 4
			end

				-- NestedClass (an index into the TypeDef table)
				-- EnclosingClass (an index into the TypeDef table)
			Result := 2 * index_size
		end

	generic_param_table_entry_size: INTEGER
			-- Compute the table entry size for the GenericParam table
		note
			EIS: "name={PE_GENERIC_PARAM_TABLE_ENTRY}.number", "protocol=uri", "src=eiffel:?class=PE_GENERIC_PARAM_TABLE_ENTRY&feature=number"
			EIS: "name={PE_GENERIC_PARAM_TABLE_ENTRY}.flags", "protocol=uri", "src=eiffel:?class=PE_GENERIC_PARAM_TABLE_ENTRY&feature=flags"
			EIS: "name={PE_GENERIC_PARAM_TABLE_ENTRY}.owner", "protocol=uri", "src=eiffel:?class=PE_GENERIC_PARAM_TABLE_ENTRY&feature=owner"
			EIS: "name={PE_GENERIC_PARAM_TABLE_ENTRY}.name", "protocol=uri", "src=eiffel:?class=PE_GENERIC_PARAM_TABLE_ENTRY&feature=name"
		local
			string_offset_size, index_size: INTEGER
		do
				-- Name
			if strings_heap_size < 65536 then
				string_offset_size := 2
			else
				string_offset_size := 4
			end

				-- Owner
			if pe_index.to_integer_32 < 65536 then
				index_size := 2
			else
				index_size := 4
			end

				-- Number (a 2-byte index of the generic parameter)
				-- Flags (a 2-byte bitmask of type GenericParamAttributes)
				-- Owner (a TypeOrMethodDef coded index into the TypeDef or MethodDef table)
				-- Name (an index into the String heap)
			Result := 2 + 2 + index_size + string_offset_size
		end

	method_spec_table_entry_size: INTEGER
			-- Compute the table entry size for the MethodSpec table
		note
			EIS: "name={PE_METHOD_SPEC_TABLE_ENTRY}.method", "protocol=uri", "src=eiffel:?class=PE_METHOD_SPEC_TABLE_ENTRY&feature=method"
			EIS: "name={PE_METHOD_SPEC_TABLE_ENTRY}.instantiation", "protocol=uri", "src=eiffel:?class=PE_METHOD_SPEC_TABLE_ENTRY&feature=instantiation"
		local
			blob_offset_size, index_size: INTEGER
		do
				-- Instantiation
			if blob_heap_size < 65536 then
				blob_offset_size := 2
			else
				blob_offset_size := 4
			end

				-- Method
			if pe_index.to_integer_32 < 65536 then
				index_size := 2
			else
				index_size := 4
			end

				-- Method (a MethodDefOrRef coded index into the MethodDef or MemberRef table)
				-- Instantiation (an index into the Blob heap)
			Result := index_size + blob_offset_size
		end

	generic_param_constraint_table_entry_size: INTEGER
			-- Compute the table entry size for the GenericParamConstraint table
		note
			EIS: "name={PE_GENERIC_PARAM_CONSTRAINTS_TABLE_ENTRY}.owner", "protocol=uri", "src=eiffel:?class=PE_GENERIC_PARAM_CONSTRAINTS_TABLE_ENTRY&feature=owner"
			EIS: "name={PE_GENERIC_PARAM_CONSTRAINTS_TABLE_ENTRY}.constraint", "protocol=uri", "src=eiffel:?class=PE_GENERIC_PARAM_CONSTRAINTS_TABLE_ENTRY&feature=constraint"
		local
			index_size: INTEGER
		do
				-- Owner and Constraint
			if pe_index.to_integer_32 < 65536 then
				index_size := 2
			else
				index_size := 4
			end

				-- Owner (an index into the GenericParam table)
				-- Constraint (a TypeDefOrRef coded index into the TypeDef, TypeRef, or TypeSpec tables)
			Result := 2 * index_size
		end

end

