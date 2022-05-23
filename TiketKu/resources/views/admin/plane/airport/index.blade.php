@extends('admin.layouts.app');

@section('content')

<div class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-2 main">
  <div class="row">
      <ol class="breadcrumb">
          <li><a href="#">
              <em class="fa fa-home"></em>
              </a></li>
          <li class="active">Airports</li>
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
            <a href="{{ url('admin/airport/create') }}" class="fa fa-plus-circle fa-2x"></a><h3 align="center">DAFTAR BANDARA</h3>
            <hr>
            <table class="table table-striped  table-bordered data">
                <thead>
                <tr>
                    <th><center>No.</center></th>
                    <th><center>Nama Bandara</center></th>
                    <th><center>Kode</center></th>
                    <th><center>Kota</center></th>
                    <th><center>Action</center></th>
                </tr>
                </thead>
                <tbody>
                @foreach($airport as $data)
                    <tr>
                        <td><center>{{ $loop->iteration }}</center></td>
                        <td><center>{{ $data->airport_name }}</center></td>
                        <td><center>{{ $data->code }}</center></td>
                        <td><center>{{ $data->city }}</center></td>
                        <td><center>
                            <form action="{{ url('admin/airport', $data->id) }}" method="post">
                                {{ csrf_field() }}
                                {{ method_field('delete') }}
                                <a href="{{ url('admin/airport/'.$data->id.'/edit') }}" class=" btn btn-sm btn-primary">Update</a>
                                <button class="btn btn-sm btn-danger" type="submit" onclick="return confirm('Yakin ingin menghapus data?')">Delete</button>
                            </form></center>
                        </td>
                    </tr>
                  @endforeach
                </tbody>
            </table>
        </div>
@endsection
