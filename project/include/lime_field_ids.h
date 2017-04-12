#ifndef LIME_FIELD_IDS_H
#define LIME_FIELD_IDS_H

namespace lime {
namespace field_ids {
#define DECLARE_LIME_FIELD_ID(s) extern int id_##s
#include "lime_field_ids_list.h"
#undef DECLARE_LIME_FIELD_ID
}
}

#endif // LIME_FIELD_IDS_H
