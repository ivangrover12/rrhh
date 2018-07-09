@extends('layouts.app') 
@section('title', 'Perfil de usuario') 
@section('content')

<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-lg-6">
        <h2>Perfil</h2>
    </div>
</div>

<div class="wrapper wrapper-content fadeInRight">
    <div class="row">
        <div class="col-lg-4">
            <div class="ibox ">
                <h2>Usuario: {{ $username }}</h2>
                <form method="POST" action="{{ route('user_reset_password') }}">
                    {{ csrf_field() }}
                    <label for="current_password">Contraseña actual:</label>
                    <input type="password" name="current_password" id="current_password" required autofocus>
                    <label for="current_password">Nueva contraseña:</label>
                    <input type="password" name="new_password" id="new_password" required>
                    <label for="current_password">Repita la nueva contraseña:</label>
                    <input type="password" name="confirm_new_password" id="confirm_new_password" required>
                    <button class="btn btn-primary" type="submit">Guardar</button>
                    @if ($errors->any())
                        @foreach ($errors->all() as $error)
                        <div class="alert alert-danger">
                            {{ $error }}
                        </div>
                        @endforeach
                    @endif
                    @if (\Session::has('success'))
                        <div class="alert alert-success">
                            <ul>
                                <li>{!! \Session::get('success') !!}</li>
                            </ul>
                        </div>
                    @endif
                </form>
            </div>
        </div>
    </div>
</div>
@endsection