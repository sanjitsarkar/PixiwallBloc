import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pixiwall/model/Tag.dart';
import 'package:pixiwall/repositories/TagsRepo.dart';

part 'tag_event.dart';
part 'tag_state.dart';

class TagBloc extends Bloc<TagEvent, TagState> {
// List<dynamic> new;

  final TagsRepo _tagsRepo;
  DocumentSnapshot lDoc;
  List<Tag> tagNew;
// List<dynamic> tagsss;
  var l;
  TagBloc({@required TagsRepo tagsRepo})
      : assert(tagsRepo != null),
        _tagsRepo = tagsRepo;
  @override
  TagState get initialState => TagInitial();

  @override
  Stream<TagState> mapEventToState(
    TagEvent event,
  ) async* {
    // TODO: implement mapEventToState

    if (event is AppStarted3) {
      yield* _mapAppStartedToState(event);
    } else if (event is RefreshTags) {
      yield* _getTags(tags: []);
    } else if (event is LoadMoreTags) {
      yield* loadMoreTags(event);
    }
  }

  Stream<TagState> loadMoreTags(LoadMoreTags event) async* {
    int limit = TagsRepo.limit;

    print(l);
    if (l >= limit) {
      yield* _getTags(
          tags: event.tags,
          limit: limit,
          lastDoc: lDoc,
          sort: event.sort,
          cat: event.cat,
          search: event.search);
    }
  }

  Stream<TagState> _getTags(
      {List<Tag> tags,
      int limit,
      DocumentSnapshot lastDoc,
      String search,
      String sort,
      String cat}) async* {
    try {
      List<Tag> tagList, tagOne;
      tagList = [];
      QuerySnapshot snap = await TagsRepo().getTags(
          limit: limit, lastDoc: lastDoc, cat: cat, search: search, sort: sort);

      l = snap.documents.length;
      // snap.documents.map((doc)
      // {
      //    catList.add(CategoryModel.fromDoc(doc));
      // });
      tagOne = snap.documents.map((doc) => Tag.fromDoc(doc)).toList();
      List tag = [];
      tagOne.forEach((m) {
// print(f.tagName);
        tag.addAll(m.tagName.substring(1, m.tagName.length - 1).split(','));
// print(tag[0]);
      });

      tag = tag.toSet().toList();
// tag.addAll(tag);
// tagsss = tagsss.toSet().toList();
// var tagsss;
// tag.addAll(tag);
      tag.forEach((t) {
        print(t);
        return tagList.add(Tag(tagName: t.toString().trim()));
// print(tag);
      });

//  tagList.map((m)
// {
// print(m.tagName);
// var tag = m.tagName.substring(1,m.tagName.length-1).split(',');
// // print(tag[0]);

// tag.addAll(tag);
// // tagsss = tagsss.toSet().toList();
// print(tag);
// }).toList();

// tagsss.map((m)
// {
//   print(m);
// });
//  tagList.map((f)
//  {
// print(f.tagName);
//  });
//  snap.documents.map((doc)
//  {
// print('Tags: ${doc['tags']}');
//  });
      List<Tag> newTagList = tags + tagList;
//     {
// catList.add(CategoryModel.fromDoc(doc));

//     });
//   });;

      // print(lDoc);
      if (l >= limit) {
        lDoc = snap.documents[snap.documents.length - 1];
      }

      yield TagLoaded(tags: newTagList);
    } catch (err) {
      print(err);

// TagError(error: err);
    }
  }

  Stream<TagState> _mapAppStartedToState(AppStarted3 event) async* {
    yield TagLoading();
    yield* _getTags(
        tags: [],
        limit: event.limit,
        sort: event.sort,
        search: event.search,
        cat: event.cat);
  }
}
