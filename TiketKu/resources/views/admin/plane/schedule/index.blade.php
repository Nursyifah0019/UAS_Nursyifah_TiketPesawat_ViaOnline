@extends('admin.layouts.app');

@section('content')
<div class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-2 main">
  <div class="row">
      <ol class="breadcrumb">
          <li><a href="#">
              <em class="fa fa-home"></em>
              </a></li>
          <li class="active">Schedule</li>
      </ol>
    </div><br><!--/.row-->

<body>

  <div class="row">
    <div class="col-md-12">
            <div class="panel panel-default">
              <div class="panel-body">
            @if(Session::has('alert-success'))
                <div class="alert alert-success">
                    <strong>{{ Session::get('alert-success') }}</strong>
                </div>
            @endif
          <a href="{{ url('admin/plane/schedule/create')}}" class="fa fa-plus-circle fa-2x"></a><h3 align="center">JADWAL PENERBANGAN</h3>
          <hr>
          <table class="table table-striped table-bordered data">
              <thead>
              <tr>
                  <th><center>NO.</center></th>
                  <th><center>Berangkat</center></th>
                  <th><center>Tujuan</center></th>
                  <th><center>Jadwal</center></th>
                  <th><center>Gate</center></th>
                  <th><center>Action</center></th>
              </tr>
              </thead>
              <tbody>
              @foreach($planeSchedule as $data)
                  <tr>
                      <td><center>{{ $loop->iteration }}</center></td>
                      <td><center>{{ $data->from }}</center></td>
                      <td><center>{{ $data->destination }}</center></td>
                      <td><center>{{ $data->boarding_time }}</center></td>
                      <td><center>{{ $data->gate }}</center></td>
                      <td><center>
                          <form action="{{ url('admin/plane/schedule/destroy', $data->id) }}" method="post">
                              {{ csrf_field() }}
                              {{ method_field('delete') }}
                              <a href="{{ url('admin/plane/schedule/detail',$data->id) }}" class="ace-icon fa fa-search-plus"> </a>
                              <a href="{{ url('admin/plane/schedule/edit',$data->id) }}" class="ace-icon fa fa-pencil"> </a>
                              <button class="ace-icon fa fa-trash-o" type="submit" onclick="return confirm('Anda yakin ingin menghapus data?')"> </button>
                          </form></center>
                      </td>
                  </tr>
              @endforeach
              </tbody>
          </table>
      </div>



@endsection
